import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/handmade_model.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionController extends GetxController {
  int pageIndex = 0;

  TextEditingController teController1 = TextEditingController();
  TextEditingController teController2 = TextEditingController();
  TextEditingController teController3 = TextEditingController();
  TextEditingController teController4 = TextEditingController();
  TextEditingController teController5 = TextEditingController();
  TextEditingController teController6 = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  void clearFocusNode() {
    focusNode1.unfocus();
    focusNode2.unfocus();
    focusNode3.unfocus();
  }

  NutritionModel nutritionModel = NutritionModel();
  MakerModel? makerModel;
  HandmadeModel? handmadeModel;

  @override
  void onReady() async {
    pageIndex = await SettingRepository.getInt(
        AppConstant.lastNutritionBottomPageIndexKey);
    update();
    super.onReady();
  }

  @override
  void onClose() {
    teController1.dispose();
    teController2.dispose();
    teController3.dispose();
    teController4.dispose();
    teController5.dispose();
    teController6.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.onClose();
  }

  void changeBody(int newPageIndex) {
    pageIndex = newPageIndex;
    update();
    SettingRepository.setInt(
        AppConstant.lastNutritionBottomPageIndexKey, pageIndex);
  }

  void onClickSaveBtn(PetsController petsController, PetModel pet) {
    if (pageIndex == 0) {
      submitMakerData(petsController, pet);
    } else {
      submitHandmadeData(petsController, pet);
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void submitMakerData(PetsController petsController, PetModel pet) {
    makerModel = MakerModel(
      makerName: teController1.text,
      givenCountPerDay:
          int.tryParse(teController2.text) ?? AppConstant.invalidNumber,
      givenGramOnce:
          int.tryParse(teController3.text) ?? AppConstant.invalidNumber,
    );

    if (makerModel!.makerName.isEmpty) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.requiredMakerName,
      );
      return;
    }
    if (makerModel!.givenCountPerDay == AppConstant.invalidNumber) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.requiredGivenCountPerDay,
      );
      return;
    }
    if (makerModel!.givenGramOnce == AppConstant.invalidNumber) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.requiredGivenGramOnce,
      );
      return;
    }

    nutritionModel.makerModel = makerModel!;

    PetModel newPet = pet.copyWith(nutritionModel: nutritionModel);
    petsController.updatePetModel(newPet, isProfileScreen: false);

    AppFunction.showSuccessEnrollMsgSnackBar(AppString.makterText.tr);
  }

  void submitHandmadeData(PetsController petsController, PetModel pet) {
    handmadeModel = HandmadeModel(
      givenGramPerDay:
          int.tryParse(teController4.text) ?? AppConstant.invalidNumber,
      givenVegetableGram:
          int.tryParse(teController5.text) ?? AppConstant.invalidNumber,
      givenProteinGram:
          int.tryParse(teController6.text) ?? AppConstant.invalidNumber,
    );

    if (handmadeModel!.givenGramPerDay == AppConstant.invalidNumber) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.requiredAmountGivenGramText,
      );
      return;
    }
    if (handmadeModel!.givenVegetableGram == AppConstant.invalidNumber) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.requiredVegetableGram,
      );
      return;
    }
    if (handmadeModel!.givenProteinGram == AppConstant.invalidNumber) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.requiredProteinGram,
      );
      return;
    }

    nutritionModel.handmadeModel = handmadeModel!;

    PetModel newPet = pet.copyWith(nutritionModel: nutritionModel);

    petsController.updatePetModel(newPet, isProfileScreen: false);

    AppFunction.showSuccessEnrollMsgSnackBar(AppString.handmadeTextTr.tr);
  }

  void initPetsNutrion(PetModel pet) {
    nutritionModel = NutritionModel();
    //

    teController1.text = '';
    teController2.text = '';
    teController3.text = '';
    teController4.text = '';
    teController5.text = '';
    teController6.text = '';

    if (pet.nutritionModel != null) {
      if (pet.nutritionModel!.makerModel != null) {
        nutritionModel.makerModel = makerModel;
        teController1.text = pet.nutritionModel!.makerModel!.makerName;
        teController2.text =
            pet.nutritionModel!.makerModel!.givenCountPerDay.toString();
        teController3.text =
            pet.nutritionModel!.makerModel!.givenGramOnce.toString();
      } else {
        teController1.text = '';
        teController2.text = '';
        teController3.text = '';
      }
      if (pet.nutritionModel!.handmadeModel != null) {
        nutritionModel.handmadeModel = handmadeModel;
        teController4.text =
            pet.nutritionModel!.handmadeModel!.givenGramPerDay.toString();
        teController5.text =
            pet.nutritionModel!.handmadeModel!.givenVegetableGram.toString();
        teController6.text =
            pet.nutritionModel!.handmadeModel!.givenProteinGram.toString();
      } else {
        teController4.text = '';
        teController5.text = '';
        teController6.text = '';
      }
    }
  }
}
