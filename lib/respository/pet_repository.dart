import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:hive/hive.dart';

class PetRepository {
  Future<void> savePet(PetModel pet) async {
    var box = await Hive.openBox<PetModel>(AppConstant.petModelBox);

    await box.put(pet.id, pet);

    print('pet saved!');
  }

  Future<bool> isExistPetName(String petName) async {
    var box = await Hive.openBox<PetModel>(AppConstant.petModelBox);

    List<PetModel> pets = box.values.toList();
    for (var pet in pets) {
      if (pet.name == petName) {
        return true;
      }
    }
    return false;
  }

  Future<bool> isExistPet(PetModel pet) async {
    var box = await Hive.openBox<PetModel>(AppConstant.petModelBox);

    bool isExistPet = await box.containsKey(pet.id);

    return isExistPet;
  }

  Future<void> deletePet(PetModel pet) async {
    var box = await Hive.openBox<PetModel>(AppConstant.petModelBox);

    // 데이터 저장
    // await box.delete(
    //     '${pet.name}-${UtilFunction.getDayYYYYMMDD(pet.birthDay)}-${pet.genderType.gender}');
    await box.delete(pet.id);
    print('Dog Deleted!');
  }

  Future<List<PetModel>> loadPets() async {
    var box = await Hive.openBox<PetModel>(AppConstant.petModelBox);

    // 데이터 읽기
    List<PetModel> pets = box.values.toList();
    pets.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    for (var pet in pets) {}
    return pets;
  }
}
