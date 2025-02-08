import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/controllers/app_review_controller.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/expensive/expensive_screen.dart';

import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:every_pet/view/setting/setting_screen.dart';
import 'package:every_pet/view/todo/todo_screen.dart';

import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetsController extends GetxController {
  PetRepository petRepository = PetRepository();
  ScrollController scrollController = ScrollController();
  late TodoController calendarController;
  late NutritionController nutritionController;
  List<PetModel>? _pets;

  PetModel? get pet => hasPets ? _pets![_petPageIndex] : null;

  bool get hasPets => _pets != null && _pets!.isNotEmpty;

  int get petsLength => hasPets ? _pets!.length : 0;

  int _petPageIndex = 0;

  int get petPageIndex => _petPageIndex;

  void changePetIndex(int newIndex) {
    if (!hasPets) {
      return;
    }
    // // 2 1
    // if (_pets!.length < newIndex) {
    //   return;
    // }
    _petPageIndex = newIndex;
    update();
  }

  PetModel? getPetOfIndex(int index) {
    if (!hasPets) {
      return null;
    }
    return _pets![index];
  }

  PersistentBottomSheetController? bottomSheetController;
  int bottomTapIndex = 0;

  List<Widget> body = const [
    TodoScreen(),
    NutritionScreen(),
    ExpensiveScreen(),
    SettingScreen()
  ];

  Future<void> setAppReviewRequest() async {
    AppReviewController.checkReviewRequest();
  }

  @override
  void onInit() async {
    super.onInit();

    _petPageIndex = await SettingRepository.getInt(AppConstant.lastPetIndexKey);
    bottomTapIndex =
        await SettingRepository.getInt(AppConstant.lastBottomTapIndexKey);

    await getPetModals(); // dont't swap to  calendarController = Get.put(TodoController()); and  nutritionController = Get.put(NutritionController());
    calendarController = Get.put(TodoController());
    nutritionController = Get.put(NutritionController());
  }

  @override
  void onReady() async {
    await setAppReviewRequest();
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future<void> deletePet() async {
    PetModel petModel = _pets![_petPageIndex];

    await calendarController.deleteTodoByPet(petModel);
    await petRepository.deletePet(petModel);
    _pets!.remove(petModel);

    if (_pets!.isEmpty) {
      Get.offAll(() => EnrollScreen(isFirst: true));
      return;
    }
    if (_petPageIndex != 0) {
      _petPageIndex -= 1;
      SettingRepository.setInt(AppConstant.lastPetIndexKey, _petPageIndex);
    }

    scrollGoToTop();
    update();
  }

  void increasePetPageIndex() {
    _petPageIndex = _petPageIndex + 1;
    SettingRepository.setInt(AppConstant.lastPetIndexKey, _petPageIndex);
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

    Get.to(() => EnrollScreen(isFirst: _pets!.isEmpty));
  }

  void onTapTopBar(int index) {
    _petPageIndex = index;
    calendarController.getTodos(_pets![_petPageIndex].name);

    update();

    SettingRepository.setInt(AppConstant.lastPetIndexKey, _petPageIndex);
    // if (bottomTapIndex == 3) {
    //   scrollGoToTop();
    // }
  }

  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300), // 애니메이션 지속 시간
      curve: Curves.easeInOut, // 애니메이션 곡선
    );
  }

  void onTapBottomBar(value) async {
    if (value != 0) {
      closeBottomSheet();
    }

    bottomTapIndex = value;

    update();

    SettingRepository.setInt(AppConstant.lastBottomTapIndexKey, bottomTapIndex);
  }

  Future<void> getPetModals() async {
    _pets = await petRepository.loadPets();

    update();
  }

  void updatePetModel(PetModel petModel, {bool isProfileScreen = true}) {
    petRepository.savePet(petModel);
    getPetModals();
    if (isProfileScreen) {
      scrollGoToTop();
    }

    // update();
  }

  // void updatePetModel(PetModel oldPet, PetModel newPet,
  //     {bool isProfileScreen = true}) {
  //   // oldPet.name = newPet.name;
  //   // oldPet.imageUrl = newPet.imageUrl;
  //   // oldPet.birthDay = newPet.birthDay;
  //   // oldPet.genderType = newPet.genderType;
  //   // oldPet.isNeuter = newPet.isNeuter;
  //   // oldPet.isPregnancy = newPet.isPregnancy;
  //   // oldPet.weight = newPet.weight;
  //   // oldPet.nutritionModel = newPet.nutritionModel;
  //   // oldPet.hospitalName = newPet.hospitalName;
  //   // oldPet.hospitalNumber = newPet.hospitalNumber;
  //   // oldPet.groomingName = newPet.groomingName;
  //   // oldPet.groomingNumber = newPet.groomingNumber;

  //   petRepository.savePet(oldPet);
  //   if (isProfileScreen) {
  //     scrollGoToTop();
  //   }

  //   update();
  // }

  Future<void> savePetModal(PetModel petModel) async {
    _pets!.add(petModel);
    petRepository.savePet(petModel);
    // getPetModals();
  }

  void aa() {
    _petPageIndex = _pets!.length - 1;
    update();
  }
}
