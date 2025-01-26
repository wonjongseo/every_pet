import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:get/get.dart';

class PetsController extends GetxController {
  PetRepository petRepository = PetRepository();

  late List<PetModel>? pets;

  @override
  void onInit() async {
    super.onInit();

    pets = await petRepository.loadDogs();
    update();
  }
}
