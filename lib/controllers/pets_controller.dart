import 'package:every_pet/controllers/calendar_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/view/calendar/calendar_screen.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:every_pet/view/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetsController extends GetxController {
  PetRepository petRepository = PetRepository();

  late CalendarController calendarController;
  List<PetModel>? pets;
  int petPageIndex = 0;
  late PageController pageController;
  PersistentBottomSheetController? bottomSheetController;
  int navigationPageIndex = 0;

  List<Widget> body = [
    HomeScreen(),
    Text('栄養画面'),
    Text('費用画面'),
    ProfileScreen()
  ];

  void tapBottomNavigatoinBar(value) {
    if (value != 0) {
      closeBottomSheet();
    }
    navigationPageIndex = value;

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

  void onClickTopBar(int index) {
    closeBottomSheet();
    petPageIndex = index;
    calendarController.getTodos(pets![petPageIndex].name);
    update();
  }

  Future<void> getPetModals() async {
    pets = await petRepository.loadDogs();
    print('pets : ${pets}');

    for (var pet in pets!) {}
    update();
  }

  Future<void> savePetModal(PetModel petModel) async {
    pets!.add(petModel);
    petRepository.saveDog(petModel);
    getPetModals();
  }
}
