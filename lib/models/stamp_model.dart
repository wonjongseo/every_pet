import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'stamp_model.g.dart';

@HiveType(typeId: 3)
class StampModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int iconIndex;

  // @HiveField(2, defaultValue: false)
  // bool isDone;

  StampModel({required this.name, required this.iconIndex});

  @override
  String toString() => 'Stamp(name: $name, icon: $iconIndex)';

  String getIcon() {
    String imagePath = '';
    switch (iconIndex) {
      case 0:
        imagePath = AppImagePath.medition1;
        break;
      case 1:
        imagePath = AppImagePath.medition2;
        break;
      case 2:
        imagePath = AppImagePath.hospital;
        break;
      case 3:
        imagePath = AppImagePath.nyuuinn;
        break;
      case 4:
        imagePath = AppImagePath.taiinn;
        break;
      case 5:
        imagePath = AppImagePath.trimming;
        break;
      case 6:
        imagePath = AppImagePath.dogrun;
        break;
      case 7:
        imagePath = AppImagePath.bug1;
        break;
    }
    return imagePath;
  }
}

List<StampModel> tempStamps = [
  StampModel(name: '薬１', iconIndex: 0),
  StampModel(name: '薬２', iconIndex: 1),
  StampModel(name: '病院', iconIndex: 2),
  StampModel(name: '入院', iconIndex: 3),
  StampModel(name: '退院', iconIndex: 4),
  StampModel(name: 'ドックラン', iconIndex: 5),
  StampModel(name: 'トリミング', iconIndex: 6),
  StampModel(name: 'フィライア', iconIndex: 7),
];
