import 'package:every_pet/models/pet_model.dart';

abstract class IPetRepository {
  Future<bool> hasPets();

  Future<void> savePet(PetModel pet);

  Future<bool> isExistPetName(String petName);

  Future<bool> isExistPet(PetModel pet);

  Future<void> deletePet(PetModel pet);

  Future<List<PetModel>> loadPets();
}
