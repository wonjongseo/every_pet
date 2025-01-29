import 'package:every_pet/common/utilities/app_constant.dart';

import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/handmade_model.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:every_pet/view/nutrition/widgets/handmake_body.dart';
import 'package:every_pet/view/nutrition/widgets/maker_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionController extends GetxController {
  // late TextEditingController makerNameEditingController;
  // late TextEditingController givenGramEditingController;
  // late TextEditingController givenGramOnceEditingController;

  late TextEditingController givenGramPerDayEditingController;
  late TextEditingController givenVegetableGramEditingController;
  late TextEditingController givenProteinGramEditingController;

  int bottomPageIndex = 0;

  // NUTRITION_TYPE foodType = NUTRITION_TYPE.DRY;

  PageController? pageController;

  PetsController petsController = Get.find<PetsController>();

  NutritionModel nutritionModel = NutritionModel();

  @override
  void onInit() async {
    super.onInit();

    bottomPageIndex = await SettingRepository.getInt(
        AppConstant.lastNutritionBottomPageIndexKey);

    pageController = PageController(initialPage: bottomPageIndex);
    // foodType = NUTRITION_TYPE.values[bottomPageIndex];

    // initHandmadeTextEditingController();

    update();
  }

  @override
  void onClose() {
    super.onClose();

    givenGramPerDayEditingController.dispose();
    givenVegetableGramEditingController.dispose();
    givenProteinGramEditingController.dispose();
  }

  void saveMaker(PetModel petModel, MakerModel makerModel) {
    petModel.nutritionModel ??= NutritionModel();
    if (petModel.nutritionModel!.makerModel != null) {
      if (petModel.nutritionModel!.makerModel! == makerModel) {
        return;
      }
    }

    NutritionModel nutritionModel = petModel.nutritionModel!;
    nutritionModel.makerModel = makerModel;
    PetModel newPet = petModel.copyWith(nutritionModel: nutritionModel);

    petsController.updatePetModel(petModel, newPet, isProfileScreen: false);
  }

  void saveHandMaker(PetModel petModel, HandmadeModel handmadeModel) {
    petModel.nutritionModel ??= NutritionModel();
    if (petModel.nutritionModel!.handmadeModel != null) {
      if (petModel.nutritionModel!.handmadeModel! == handmadeModel) {
        return;
      }
    }

    NutritionModel nutritionModel = petModel.nutritionModel!;
    nutritionModel.handmadeModel = handmadeModel;
    PetModel newPet = petModel.copyWith(nutritionModel: nutritionModel);

    petsController.updatePetModel(petModel, newPet, isProfileScreen: false);
  }

  bool isTap = false;
  void onTapBottomNavigation(NUTRITION_TYPE? nutritionType) {
    if (isTap == true) return;
    if (nutritionType == null) return;

    // if (foodType == nutritionType) return;

    isTap = true;

    // foodType = nutritionType;

    update();

    if (nutritionType == NUTRITION_TYPE.DRY) {
      bottomPageIndex = NUTRITION_TYPE.DRY.index;
    } else {
      bottomPageIndex = NUTRITION_TYPE.MANUL.index;
    }

    print('bottomPageIndex : ${bottomPageIndex}');

    SettingRepository.setInt(
        AppConstant.lastNutritionBottomPageIndexKey, bottomPageIndex);

    pageController!.animateToPage(
      bottomPageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );

    isTap = false;
  }

  void initHandmadeTextEditingController(PetModel petModel) {
    String givenGramPerDayString = '';
    String givenVegetableGramString = '';
    String givenProteinGramString = '';

    if (petModel.nutritionModel != null &&
        petModel.nutritionModel!.handmadeModel != null) {
      givenGramPerDayString =
          petModel.nutritionModel!.handmadeModel!.givenGramPerDay.toString();
      givenVegetableGramString =
          petModel.nutritionModel!.handmadeModel!.givenProteinGram.toString();
      givenProteinGramString =
          petModel.nutritionModel!.handmadeModel!.givenVegetableGram.toString();
    }

    givenGramPerDayEditingController =
        TextEditingController(text: givenGramPerDayString);
    givenVegetableGramEditingController =
        TextEditingController(text: givenVegetableGramString);
    givenProteinGramEditingController =
        TextEditingController(text: givenProteinGramString);
  }

  void onPageChanged(value) {
    bottomPageIndex = value;
    update();
  }
}
