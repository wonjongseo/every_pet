import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:get/get.dart';

class CalculateKcalController extends GetxController {
  PetsController petsController = Get.find<PetsController>();

  late PetModel pet;

  @override
  void onInit() {
    super.onInit();
    pet = petsController.pets![petsController.petPageIndex];
    update();
  }
}
