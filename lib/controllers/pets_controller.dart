import 'package:every_pet/controllers/calendar_controller.dart';
import 'package:every_pet/controllers/profile_controller.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
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
  ScrollController scrollController = ScrollController();
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

  @override
  void onInit() async {
    super.onInit();
    petPageIndex = await SettingRepository.getInt(SettingKey.lastPetIndex);
    bottomTapIndex =
        await SettingRepository.getInt(SettingKey.lastBottomTapIndex);

    pageController = PageController(initialPage: petPageIndex);

    await getPetModals();
    calendarController = Get.put(CalendarController());

    // calendarController.getTodos(pets![petPageIndex].name);
  }

  @override
  void onClose() {
    pageController.dispose();
    scrollController.dispose();
  }

  void deletePet() async {
    PetModel petModel = pets![petPageIndex];

    await calendarController.deleteTodoByPet(petModel);
    await petRepository.deletePet(petModel);
    pets!.remove(petModel);

    if (petPageIndex != 0) {
      petPageIndex -= 1;
      SettingRepository.setInt(SettingKey.lastPetIndex, petPageIndex);
    }

    scrollGoToTop();
    update();
  }

  void increasePetPageIndex() {
    petPageIndex = petPageIndex + 1;
    SettingRepository.setInt(SettingKey.lastPetIndex, petPageIndex);
    update();
  }

  void closeBottomSheet() {
    if (bottomSheetController != null) {
      bottomSheetController!.close();
      bottomSheetController = null;
    }
  }

  void goToEnrollScreen() async {
    closeBottomSheet();
    // Get.put(EnrollController());

    Get.to(() => EnrollScreen(isFirst: pets!.isEmpty));
  }

  void onTapTopBar(int index) {
    petPageIndex = index;
    calendarController.getTodos(pets![petPageIndex].name);
    update();

    SettingRepository.setInt(SettingKey.lastPetIndex, petPageIndex);
    if (bottomTapIndex == 3) {
      scrollGoToTop();
    }
  }

  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300), // 애니메이션 지속 시간
      curve: Curves.easeInOut, // 애니메이션 곡선
    );
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
    update();
  }

  void updaetPetModel(PetModel oldPet, PetModel newPet) {
    for (var i = 0; i < pets!.length; i++) {
      if (pets![i] == oldPet) {
        pets![i] = newPet;
      }
    }
  }

  Future<void> savePetModal(PetModel petModel) async {
    pets!.add(petModel);
    petRepository.savePet(petModel);
    getPetModals();
  }
}
