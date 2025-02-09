// class FoodModel {}

import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:uuid/uuid.dart';
part 'handmade_model.g.dart';

@HiveType(typeId: AppConstant.handmadeModelHiveId)
class HandmadeModel {
  @HiveField(0)
  int givenGramPerDay; // あげる量

  @HiveField(1)
  int givenVegetableGram; //あげる野菜りょう

  @HiveField(2)
  int givenProteinGram; // 蛋白質りょう

  @HiveField(3)
  late String id;

  @HiveField(4)
  late int createdAt;

  HandmadeModel({
    required this.givenGramPerDay,
    required this.givenVegetableGram,
    required this.givenProteinGram,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'HandmadeModel(givenGramPerDay: $givenGramPerDay, givenVegetableGram: $givenVegetableGram, givenProteinGram: $givenProteinGram, id: $id, createdAt: $createdAt)';
  }
}
