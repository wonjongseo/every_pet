import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:every_pet/common/utilities/app_constant.dart';

part 'groceries_modal.g.dart';

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
    id = const Uuid().v4();
    createdAt = DateTime.now();
  }

  double get kcal {
    return _gram * _kcalPerGram;
  }

  double get kcalPerGram => _kcalPerGram;

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

  GroceriesModel copyWith({
    String? name,
    double? kcalPerGram,
    int? gram,
  }) {
    return GroceriesModel(
      name: name ?? this.name,
      kcalPer100g: kcalPerGram ?? this._kcalPerGram,
      gram: gram ?? this._gram,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroceriesModel &&
        other.name == name &&
        other._kcalPerGram == _kcalPerGram &&
        other._gram == _gram;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        _kcalPerGram.hashCode ^
        _gram.hashCode ^
        id.hashCode ^
        createdAt.hashCode;
  }
}
