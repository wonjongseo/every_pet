import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';

@HiveType(typeId: AppConstant.groceriesModelHiveId)
class GroceriesModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  final double _kcalPerGram;
  @HiveField(2)
  int _gram;

  @HiveField(7)
  late String id;

  @HiveField(8)
  late DateTime createdAt;

  GroceriesModel(
      {required this.name, required double kcalPer100g, int gram = 100})
      : _kcalPerGram = kcalPer100g / 100,
        _gram = gram {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    createdAt = DateTime.now();
  }

  double get kcal => _gram * _kcalPerGram;

  set kcal(double value) {
    _gram = (value / _kcalPerGram).round();
  }

  int get gram => _gram;
  set gram(int value) {
    if (value < 0) return; // 음수 방지
    _gram = value;
  }

  @override
  String toString() {
    return 'GroceriesModel(name: $name, _kcalPerGram: $_kcalPerGram, _gram: $_gram, id: $id, createdAt: $createdAt)';
  }
}
