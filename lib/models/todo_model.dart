import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/models/stamp_model.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 4)
class TodoModel {
  @HiveField(0)
  List<StampModel> stamps;
  @HiveField(1)
  String memo;
  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  PetModel? petModel;

  TodoModel(
      {required this.stamps,
      required this.memo,
      required this.dateTime,
      this.petModel});

  @override
  String toString() =>
      'TodoModel(stamps: $stamps, memo: $memo, dateTime: $dateTime, petModel: $petModel)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.memo == memo &&
        other.dateTime == dateTime &&
        other.petModel == petModel;
  }

  @override
  int get hashCode {
    return memo.hashCode ^ dateTime.hashCode ^ petModel.hashCode;
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
