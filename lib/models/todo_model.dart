import 'package:hive/hive.dart';

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

  TodoModel({required this.stamps, required this.memo, required this.dateTime});

  @override
  String toString() =>
      'TodoModel(stamps: $stamps, memo: $memo, dateTime: $dateTime)';
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
