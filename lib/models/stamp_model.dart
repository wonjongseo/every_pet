import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_image_path.dart';

part 'stamp_model.g.dart';

@HiveType(typeId: 3)
class StampModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int iconIndex;

  @HiveField(2, defaultValue: false)
  bool isCustom;

  @HiveField(3)
  bool isVisible;

  // @HiveField(2, defaultValue: false)
  // bool isDone;

  StampModel({
    required this.name,
    required this.iconIndex,
    required this.isVisible,
    this.isCustom = false,
  });

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
      case 8:
        imagePath = AppImagePath.pudlle;
      case 9:
        imagePath = AppImagePath.bug2;
      default:
        imagePath = AppImagePath.bisyon;
        break;
    }
    return imagePath;
  }

  Color getColor() {
    switch (iconIndex) {
      case 0:
        return const Color(0xFFff9796);

      case 1:
        return const Color(0xFF229cff);

      case 2:
        return const Color(0xFF56e1ff);

      case 3:
        return const Color(0xFFf59b23);

      case 4:
        return const Color(0xFFf59b23);

      case 5:
        return const Color(0xFF7ec636);

      case 6:
        return const Color(0xFFe5b7ff);

      case 7:
        return const Color(0xFFdbff85);

      default:
        return const Color(0xFF000000).withOpacity(.8);
    }
  }

  @override
  String toString() {
    return 'StampModel(name: $name, iconIndex: $iconIndex, isCustom: $isCustom, isVisible: $isVisible)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StampModel &&
        other.name == name &&
        other.iconIndex == iconIndex &&
        other.isCustom == isCustom &&
        other.isVisible == isVisible;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        iconIndex.hashCode ^
        isCustom.hashCode ^
        isVisible.hashCode;
  }
}

// List<StampModel> tempStamps = [
//   StampModel(name: '薬１', iconIndex: 0),
//   StampModel(name: '薬２', iconIndex: 1),
//   StampModel(name: '病院', iconIndex: 2),
//   StampModel(name: '入院', iconIndex: 3),
//   StampModel(name: '退院', iconIndex: 4),
//   StampModel(name: 'ドックラン', iconIndex: 5),
//   StampModel(name: 'トリミング', iconIndex: 6),
//   StampModel(name: 'フィライア', iconIndex: 7),
// ];

 