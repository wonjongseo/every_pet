import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/expensive/expensive_screen.dart';
import 'package:every_pet/view/new_nutrition/new_nutrition_screen.dart';
import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:every_pet/view/setting/setting_screen.dart';
import 'package:every_pet/view/todo/todo_screen.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetsController extends GetxController {
  PetRepository petRepository = PetRepository();
  ScrollController scrollController = ScrollController();
  late TodoController calendarController;
  late NutritionController nutritionController;
  List<PetModel>? pets;
  int petPageIndex = 0;
  PersistentBottomSheetController? bottomSheetController;
  int bottomTapIndex = 0;

  List<Widget> body = const [
    TodoScreen(),
    NutritionScreen(),
    ExpensiveScreen(),
    SettingScreen()
  ];

  @override
  void onInit() async {
    super.onInit();
    petPageIndex = await SettingRepository.getInt(AppConstant.lastPetIndexKey);
    bottomTapIndex =
        await SettingRepository.getInt(AppConstant.lastBottomTapIndexKey);

    await getPetModals();
    calendarController = Get.put(TodoController());
    nutritionController = Get.put(NutritionController());
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future<void> deletePet() async {
    PetModel petModel = pets![petPageIndex];

    await calendarController.deleteTodoByPet(petModel);
    await petRepository.deletePet(petModel);
    pets!.remove(petModel);

    if (petPageIndex != 0) {
      petPageIndex -= 1;
      SettingRepository.setInt(AppConstant.lastPetIndexKey, petPageIndex);
    }

    scrollGoToTop();
    update();
  }

  void increasePetPageIndex() {
    petPageIndex = petPageIndex + 1;
    SettingRepository.setInt(AppConstant.lastPetIndexKey, petPageIndex);
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

    SettingRepository.setInt(AppConstant.lastPetIndexKey, petPageIndex);
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
    pets = await petRepository.loadPets();
    update();
  }

  void updatePetModel(PetModel oldPet, PetModel newPet,
      {bool isProfileScreen = true}) {
    oldPet.name = newPet.name;
    oldPet.imageUrl = newPet.imageUrl;
    oldPet.birthDay = newPet.birthDay;
    oldPet.genderType = newPet.genderType;
    oldPet.isNeuter = newPet.isNeuter;
    oldPet.isPregnancy = newPet.isPregnancy;
    oldPet.weight = newPet.weight;
    oldPet.nutritionModel = newPet.nutritionModel;

    petRepository.savePet(oldPet);
    if (isProfileScreen) {
      scrollGoToTop();
    }

    update();
  }

  Future<void> savePetModal(PetModel petModel) async {
    pets!.add(petModel);
    petRepository.savePet(petModel);
    // getPetModals();
  }

  void aa() {
    petPageIndex = pets!.length - 1;
    update();
  }
}
