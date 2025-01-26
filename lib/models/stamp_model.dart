import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'stamp_model.g.dart';

@HiveType(typeId: 3)
class StampModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  IconData icon;

  // @HiveField(2, defaultValue: false)
  // bool isDone;

  StampModel({required this.name, required this.icon});

  @override
  String toString() => 'Stamp(name: $name, icon: $icon)';
}
