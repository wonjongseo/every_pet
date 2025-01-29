// class FoodModel {}

import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';

part 'handmade_model.g.dart';

@HiveType(typeId: AppConstant.handmadeModelHiveId)
class HandmadeModel {
  @HiveField(0)
  double givenGramPerDay; // あげる量

  @HiveField(1)
  double givenVegetableGram; //あげる野菜りょう

  @HiveField(2)
  double givenProteinGram; // 蛋白質りょう

  @HiveField(3)
  late String id;

  @HiveField(4)
  late DateTime createdAt;

  HandmadeModel({
    required this.givenGramPerDay,
    required this.givenVegetableGram,
    required this.givenProteinGram,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    createdAt = DateTime.now();
  }
}
