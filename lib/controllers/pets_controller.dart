import 'package:every_pet/controllers/calendar_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/todo/todo_screen.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetsController extends GetxController {
  PetRepository petRepository = PetRepository();

  late CalendarController calendarController;
  List<PetModel>? pets;
  int petPageIndex = 0;
  late PageController pageController;
  PersistentBottomSheetController? bottomSheetController;
  int bottomTapIndex = 0;

  List<Widget> body = [
    TodoScreen(),
    Text('栄養画面'),
    Text('費用画面'),
    ProfileScreen()
  ];

  void deletePet() async {
    PetModel petModel = pets![petPageIndex];

    await calendarController.deleteTodoByPet(petModel);
    await petRepository.deletePet(petModel);
    pets!.remove(petModel);

    if (petPageIndex != 0) {
      petPageIndex -= 1;
    }
    update();
  }

  void closeBottomSheet() {
    if (bottomSheetController != null) {
      bottomSheetController!.close();
      bottomSheetController = null;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    petPageIndex = await SettingRepository.getInt(SettingKey.lastPetIndex);
    bottomTapIndex =
        await SettingRepository.getInt(SettingKey.lastBottomTapIndex);
    print('petPageIndex : ${petPageIndex}');

    pageController = PageController(initialPage: petPageIndex);

    await getPetModals();
    calendarController = Get.put(CalendarController());

    // calendarController.getTodos(pets![petPageIndex].name);
  }

  @override
  void onClose() {
    pageController.dispose();
  }

  void goToEnrollScreen() {
    closeBottomSheet();

    Get.to(() => const EnrollScreen());
  }

  void onTapTopBar(int index) {
    petPageIndex = index;
    calendarController.getTodos(pets![petPageIndex].name);
    update();

    SettingRepository.setInt(SettingKey.lastPetIndex, petPageIndex);
  }

  void onTapBottomBar(value) {
    if (value != 0) {
      closeBottomSheet();
    }
    bottomTapIndex = value;

    update();

    SettingRepository.setInt(SettingKey.lastBottomTapIndex, bottomTapIndex);
  }

  Future<void> getPetModals() async {
    pets = await petRepository.loadPets();
    print('pets : ${pets}');

    for (var pet in pets!) {}
    update();
  }

  Future<void> savePetModal(PetModel petModel) async {
    pets!.add(petModel);
    petRepository.savePet(petModel);
    getPetModals();
  }
}
