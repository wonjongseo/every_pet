import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:hive/hive.dart';

class PetRepository {
  Future<void> savePet(PetModel pet) async {
    var box = await Hive.openBox<PetModel>('pets');

    // 데이터 저장
    // await box.add(pet);
    await box.put(
        '${pet.name}-${UtilFunction.getDayYYYYMMDD(pet.birthDay)}-${pet.genderType.gender}',
        pet);

    print('pet saved!');
  }

  Future<bool> isExistPet(PetModel pet) async {
    var box = await Hive.openBox<PetModel>('pets');

    // 데이터 저장
    // await box.add(pet);
    bool isExistPet = await box.containsKey(
        '${pet.name}-${UtilFunction.getDayYYYYMMDD(pet.birthDay)}-${pet.genderType.gender}');

    return isExistPet;
  }

  Future<void> deletePet(PetModel pet) async {
    var box = await Hive.openBox<PetModel>('pets');

    // 데이터 저장
    await box.delete(
        '${pet.name}-${UtilFunction.getDayYYYYMMDD(pet.birthDay)}-${pet.genderType.gender}');

    print('Dog Deleted!');
  }

  Future<List<PetModel>> loadPets() async {
    var box = await Hive.openBox<PetModel>('pets');

    // 데이터 읽기
    List<PetModel> pets = box.values.toList();
    pets.sort((a, b) => a.birthDay.compareTo(b.birthDay));

    for (var pet in pets) {
      print('pet : ${pet}');
    }

    for (var pet in pets) {}
    return pets;
  }
}
