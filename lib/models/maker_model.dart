// class FoodModel {}

import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:uuid/uuid.dart';
part 'maker_model.g.dart';

@HiveType(typeId: AppConstant.makerModelHiveId)
class MakerModel {
  @HiveField(0)
  String makerName; // メーカ

  @HiveField(1)
  int givenCountPerDay; // あげる回数

  @HiveField(2)
  int givenGramOnce; // 一回につきg

  @HiveField(3)
  late String id;

  @HiveField(4)
  late int createdAt;

  MakerModel({
    required this.makerName,
    required this.givenCountPerDay,
    required this.givenGramOnce,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'MakerModel(makerName: $makerName, givenGram: $givenCountPerDay, givenGramOnce: $givenGramOnce, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MakerModel &&
        other.makerName == makerName &&
        other.givenCountPerDay == givenCountPerDay &&
        other.givenGramOnce == givenGramOnce;
  }

  @override
  int get hashCode {
    return makerName.hashCode ^
        givenCountPerDay.hashCode ^
        givenGramOnce.hashCode ^
        id.hashCode ^
        createdAt.hashCode;
  }
}
