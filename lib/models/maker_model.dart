// class FoodModel {}

import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';

@HiveType(typeId: AppConstant.makerModelHiveId)
class MakerModel {
  @HiveField(0)
  String makerName; // メーカ

  @HiveField(1)
  double givenGram; // あげる回数

  @HiveField(2)
  double givenGramOnce; // 一回につきg

  @HiveField(3)
  late String id;

  @HiveField(4)
  late DateTime createdAt;

  MakerModel({
    required this.makerName,
    required this.givenGram,
    required this.givenGramOnce,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    createdAt = DateTime.now();
  }
}
