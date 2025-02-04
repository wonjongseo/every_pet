import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/respository/groceries_repository.dart';
import 'package:get/get.dart';

import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';

class DisplayGrocery {
  String? name;
  String? kcal;
  String? gram;

  DisplayGrocery({this.name, this.kcal, this.gram});
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
    pet = petsController.pets![petsController.petPageIndex];
    super.onInit();
  }

  @override
  void onReady() {
    getAllGroceries();
    super.onReady();
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
