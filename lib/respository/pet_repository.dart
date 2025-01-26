import 'package:every_pet/models/dog_model.dart';
import 'package:hive/hive.dart';

class PetRepository {
  void saveDog(DogModel dog) async {
    var box = await Hive.openBox<DogModel>('dogs');

    // 데이터 저장
    await box.add(dog);

    print('Dog saved!');
  }

  Future<List<DogModel>> loadDogs() async {
    var box = await Hive.openBox<DogModel>('dogs');

    // 데이터 읽기
    List<DogModel> dogs = box.values.toList();

    print('dogs.length : ${dogs.length}');

    for (var dog in dogs) {
      print('dog : ${dog}');
    }
    return dogs;
  }
}
