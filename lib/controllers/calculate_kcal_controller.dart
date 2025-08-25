import 'package:every_pet/common/admob/interstitial_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/groceries_repository.dart';

class DisplayGrocery {
  String? name;
  String? kcal;
  String? gram;

  DisplayGrocery({this.name, this.kcal, this.gram});

  @override
  String toString() => 'DisplayGrocery(name: $name, kcal: $kcal, gram: $gram)';
}

class CalculateKcalController extends GetxController {
  PetsController petsController = Get.find<PetsController>();
  late PetModel pet;
  GroceriesRepository groceriesRepository = GroceriesRepository();
  List<GroceriesModel> groceriesModels = [];
  List<GroceriesModel> selectedGroceriesModels = [];

  List<DisplayGrocery> displayGroceries = [];
  int givenCountPerDay = 1;

  @override
  void onInit() {
    initPetInfo();
    super.onInit();
  }

  initPetInfo() async {
    pet = petsController.pet!;

    int? savedGivenCountPerDay =
        await groceriesRepository.getGivenCountPerDay();

    if (savedGivenCountPerDay == null) {
      givenCountPerDay = pet.nutritionModel?.makerModel?.givenCountPerDay ?? 1;
    } else {
      givenCountPerDay = savedGivenCountPerDay;
    }
  }

  @override
  void onReady() {
    getAllGroceries();
    getSavedMenuIndex();
    super.onReady();
  }

  @override
  void onClose() {
    putSavedMenuIndex();
    putGivenCountPerDay();

    super.onClose();
  }

  void putGivenCountPerDay() {
    groceriesRepository.savedGivenCountPerDay(givenCountPerDay);
  }

  void getSavedMenuIndex() async {
    List<int> selectedMenus = await groceriesRepository.getSelectedMenus();

    for (var index in selectedMenus) {
      onAddBtnClick(groceriesModels[index]);
    }
  }

  void putSavedMenuIndex() {
    List<int> selectedMenus = [];
    for (var i = 0; i < groceriesModels.length; i++) {
      if (selectedGroceriesModels.contains(groceriesModels[i])) {
        selectedMenus.add(i);
      }
    }
    groceriesRepository.savedSelectedMenus(selectedMenus);
  }

  void addNewGrocery() async {
    List<TextEditingController> teControllers = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(text: '100'),
    ];

    bool? result = await AppFunction.multiTextEditDialog(
      teControllers: teControllers,
      hintTexts: [AppString.menuName, '0.0', '0'],
      sufficTexts: ['', 'kcal', 'gram'],
      buttonLabel: AppString.enrollTextBtnTr.tr,
      keyboardTypes: [
        TextInputType.text,
        const TextInputType.numberWithOptions(decimal: true),
        TextInputType.number
      ],
    );
    if (result == null) {
      return;
    }

    for (var element in teControllers) {
      if (element.text.isEmpty) {
        AppFunction.showInvalidTextFieldSnackBar(message: '빈 항목 없이 입력해주세요.');
      }
    }

    GroceriesModel groceriesModel = GroceriesModel(
        name: teControllers[0].text,
        kcalPer100g: double.parse(teControllers[1].text),
        gram: int.parse(teControllers[2].text));

    AppFunction.showSuccessEnrollMsgSnackBar(groceriesModel.name);
    saveCategory(groceriesModel);
    InterstitialManager.instance.maybeShow();
  }

  void saveCategory(GroceriesModel groceriesModel) {
    groceriesRepository.saveGrocery(groceriesModel);
    getAllGroceries();
  }

  void updateGrocery(int index, String name, String kcal, String gram) {
    GroceriesModel groceriesModel = groceriesModels[index];

    if (name.isEmpty) {
      name = groceriesModel.name;
    }
    if (kcal.isEmpty) {
      kcal = groceriesModel.kcal.toStringAsFixed(1);
    }
    if (gram.isEmpty) {
      gram = groceriesModel.gram.toString();
    }

    if (groceriesModel.name == name &&
        groceriesModel.kcal.toStringAsFixed(1) == kcal &&
        groceriesModel.gram.toString() == gram) {
      return;
    }

    GroceriesModel newGroceriesModel = groceriesModel.copyWith(
      name: name,
      kcalPerGram: double.parse(kcal),
      gram: int.parse(gram),
    );

    AppFunction.showSuccessEnrollMsgSnackBar(newGroceriesModel.name);
    saveCategory(newGroceriesModel);
  }

  void deleteGrocery(GroceriesModel groceriesModel) {
    AppFunction.showMessageSnackBar(
        title: AppString.deleteBtnText.tr,
        message: '${groceriesModel.name}　${AppString.doneDeletionMsg.tr}');
    groceriesRepository.deleteGrocery(groceriesModel);
    getAllGroceries();
  }

  Future<void> getAllGroceries() async {
    groceriesModels = await groceriesRepository.getGroceries();

    update();
  }

  changeCountPerDay(int? value) {
    if (value == null) return;
    givenCountPerDay = value!;
    distributeDER();
    update();
  }

  void onRemoteBtnClick(int index) {
    selectedGroceriesModels.removeAt(index);
    displayGroceries.removeAt(index);

    distributeDER();
    update();
  }

  void onAddBtnClick(GroceriesModel groceriesModel) {
    if (selectedGroceriesModels.contains(groceriesModel)) {
      return;
    }

    selectedGroceriesModels.add(groceriesModel);
    displayGroceries.add(DisplayGrocery());

    distributeDER();
    update();
  }

  void distributeDER() {
    double? derValue = pet.getDER();

    if (derValue > 0) {
      double ratioKcal =
          derValue / selectedGroceriesModels.length / givenCountPerDay;

      for (var i = 0; i < selectedGroceriesModels.length; i++) {
        var gram = (ratioKcal / selectedGroceriesModels[i].kcalPerGram);

        var kcal = gram * selectedGroceriesModels[i].kcalPerGram;

        displayGroceries[i].name = selectedGroceriesModels[i].name;
        displayGroceries[i].kcal = (kcal.toStringAsFixed(1));
        displayGroceries[i].gram = (gram.toStringAsFixed(1));
      }
    }
  }
}
