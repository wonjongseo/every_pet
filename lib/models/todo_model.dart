import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/models/stamp_model.dart';

part 'todo_model.g.dart';

@HiveType(typeId: AppConstant.todoModelHiveId)
class TodoModel {
  @HiveField(0)
  List<StampModel> stamps;
  @HiveField(1)
  String memo;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  PetModel? petModel;
  @HiveField(4)
  late String id;
  @HiveField(5)
  late int createdAt;

  TodoModel(
      {required this.stamps,
      required this.memo,
      required this.dateTime,
      this.petModel}) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() =>
      'TodoModel(stamp: $stamps, memo: $memo, dateTime: $dateTime, petModel: $petModel)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoModel &&
        other.dateTime == dateTime &&
        other.petModel == petModel;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^ petModel.hashCode;
  }

  TodoModel copyWith({
    List<StampModel>? stamps,
    String? memo,
    DateTime? dateTime,
    PetModel? petModel,
  }) {
    TodoModel newTodo = TodoModel(
      stamps: stamps ?? this.stamps,
      memo: memo ?? this.memo,
      dateTime: dateTime ?? this.dateTime,
      petModel: petModel ?? this.petModel,
    );
    newTodo.id = id;
    newTodo.createdAt = createdAt;
    return newTodo;
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
