import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/respository/groceries_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';

class CalculateKcalController extends GetxController {
  bool isEdit = false;

  void toggleIsEdit() {
    isEdit = !isEdit;
    update();
  }

  PetsController petsController = Get.find<PetsController>();

  GroceriesRepository groceriesRepository = GroceriesRepository();

  TextEditingController editingController = TextEditingController();
  late PetModel pet;
  List<GroceriesModel> groceriesModels = [];
  List<TextEditingController> gramControllers = [];
  List<TextEditingController> kcalControllers = [];

  List<GroceriesModel> selectedGroceriesModels = [];
  List<TextEditingController> selectedGramControllers = [];
  List<TextEditingController> selectedKcalControllers = [];

  int givenCountPerDay = 1;

  Future<void> getAllGroceries() async {
    groceriesModels = await groceriesRepository.getGroceries();

    update();
  }

  @override
  void onInit() async {
    super.onInit();
    pet = petsController.pets![petsController.petPageIndex];

    if (pet.nutritionModel != null && pet.nutritionModel!.makerModel != null) {
      // pet.nutritionModel!.makerModel!.givenGram
    }
    await getAllGroceries();

    gramControllers = List.generate(
      groceriesModels.length,
      (index) =>
          TextEditingController(text: groceriesModels[index].gram.toString()),
    );

    kcalControllers = List.generate(
      groceriesModels.length,
      (index) => TextEditingController(
          text: groceriesModels[index].kcal.toStringAsFixed(1)),
    );

    update();
  }

  void updateGram(String value, int index) {
    if (value.isEmpty || value == '') return;

    int? gram = int.parse(value);

    if (gram != null) {
      groceriesModels[index].gram =
          int.tryParse(value) ?? groceriesModels[index].gram;

      kcalControllers[index].text =
          groceriesModels[index].kcal.toStringAsFixed(1);
    }

    update();
  }

  void updateKcal(String value, int index) {
    double? kcal = double.tryParse(value);
    if (kcal != null) {
      groceriesModels[index].kcal = kcal;
      gramControllers[index].text = groceriesModels[index].gram.toString();
    }
    update();
  }

  void changeGivenCountPerDay(int? value) {
    if (value == null) return;
    givenCountPerDay = value;

    distributeDER();
    update();
  }

  void onRemoteBtnClick(int index) {
    selectedGroceriesModels.removeAt(index);
    selectedGramControllers.removeAt(index);
    selectedKcalControllers.removeAt(index);
    distributeDER();
    update();
  }

  void deleteGrocery(GroceriesModel groceriesModel) {
    groceriesRepository.deleteGrocery(groceriesModel);
    getAllGroceries();
  }

  void onAddBtnClick(GroceriesModel groceriesModel) {
    if (selectedGroceriesModels.contains(groceriesModel)) {
      return;
    }
    selectedGroceriesModels.add(groceriesModel);
    selectedGramControllers.add(TextEditingController());
    selectedKcalControllers.add(TextEditingController());
    distributeDER();
    update();
  }

  void distributeDER() {
    double? derValue = pet.getDER();
    if (derValue != null && derValue > 0) {
      double ratioKcal =
          derValue / selectedGroceriesModels.length / givenCountPerDay;

      for (var i = 0; i < selectedGroceriesModels.length; i++) {
        selectedGroceriesModels[i].kcal = ratioKcal;
        selectedKcalControllers[i].text =
            selectedGroceriesModels[i].kcal.toStringAsFixed(1);
        selectedGramControllers[i].text =
            selectedGroceriesModels[i].gram.toString();
      }
    }
  }
}
