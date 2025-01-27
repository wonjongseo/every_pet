import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:hive/hive.dart';

class PetRepository {
  Future<void> saveDog(PetModel pet) async {
    var box = await Hive.openBox<PetModel>('pets');

    // 데이터 저장
    await box.add(pet);

    print('pet saved!');
  }

  Future<List<PetModel>> loadDogs() async {
    var box = await Hive.openBox<PetModel>('pets');

    // 데이터 읽기
    List<PetModel> pets = box.values.toList();

    print('pet.length : ${pets.length}');

    for (var pet in pets) {}
    return pets;
  }
}
