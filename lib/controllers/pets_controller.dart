import 'package:every_pet/controllers/calendar_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetsController extends GetxController {
  PetRepository petRepository = PetRepository();

  CalendarController calendarController = Get.put(CalendarController());
  List<PetModel>? pets;
  int petPageIndex = 0;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: petPageIndex);
    getPetModals();
  }

  @override
  void onClose() {
    pageController.dispose();
  }

  void onClickTopBar(int index) {
    petPageIndex = index;
    update();
  }

  Future<void> getPetModals() async {
    pets = await petRepository.loadDogs();
    print('pets : ${pets}');

    for (var pet in pets!) {
      print('pet : ${pet}');
    }
    update();
  }

  Future<void> savePetModal(PetModel petModel) async {
    pets!.add(petModel);
    petRepository.saveDog(petModel);
    getPetModals();
  }
}
