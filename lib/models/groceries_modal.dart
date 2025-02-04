import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:uuid/uuid.dart';
part 'groceries_modal.g.dart';

//groceries_modal.dart
@HiveType(typeId: AppConstant.groceriesModelHiveId)
class GroceriesModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  final double kcalPerGram;
  @HiveField(2)
  int foodGram;

  @HiveField(7)
  late String id;

  @HiveField(8)
  late DateTime createdAt;

  GroceriesModel(
      {required this.name, required double kcalPerGram, int gram = 100})
      : kcalPerGram = kcalPerGram / 100,
        foodGram = gram {
    id = const Uuid().v4();
    createdAt = DateTime.now();
  }

  double get kcal => foodGram * kcalPerGram;

  set kcal(double value) {
    foodGram = (value / kcalPerGram).round();
  }

  int get gram => foodGram;
  set gram(int value) {
    if (value < 0) return; // 음수 방지
    foodGram = value;
  }

  @override
  String toString() {
    return 'GroceriesModel(name: $name, _kcalPerGram: $kcalPerGram, _gram: $foodGram, id: $id, createdAt: $createdAt)';
  }
}
