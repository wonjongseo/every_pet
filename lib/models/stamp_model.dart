import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';

part 'stamp_model.g.dart';

@HiveType(typeId: AppConstant.stampModelHiveId)
class StampModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int iconIndex;

  @HiveField(2, defaultValue: true)
  bool isVisible;

  @HiveField(3)
  late String id;

  @HiveField(4)
  late int createdAt;

  // @HiveField(2, defaultValue: false)
  // bool isDone;

  StampModel({
    required this.name,
    required this.iconIndex,
    required this.isVisible,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  static String getIcon(iconIndex) {
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
        break;
      case 9:
        imagePath = AppImagePath.bug2;
        break;
      case 10:
        imagePath = AppImagePath.circleTravel;
        break;
      case 11:
        imagePath = AppImagePath.circleBisyon;
        break;
      case 12:
        imagePath = AppImagePath.circleMatiz;
        break;
      case 13:
        imagePath = AppImagePath.circleSiba;
        break;
      case 14:
        imagePath = AppImagePath.circleSyringe;
        break;
      case 15:
        imagePath = AppImagePath.circleBuldog;
        break;
      case 16:
        imagePath = AppImagePath.cirlceSyunauza;
        break;
      default:
        imagePath = AppImagePath.circleBisyon;
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
        return const Color(0xFF56e1ff); //ok

      case 3:
        return const Color(0xFFf59b23);

      case 4:
        return const Color(0xFFf59b23);

      case 5:
        return const Color(0xFFe5b7ff);

      case 6:
        return const Color(0xFF7ec636);

      case 7:
        return const Color(0xFFdbff85);

      default:
        return const Color(0xFF000000).withOpacity(.8);
    }
  }

  @override
  String toString() {
    return 'StampModel(id: $id, name: $name, iconIndex: $iconIndex, isVisible: $isVisible)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StampModel &&
        other.name == name &&
        other.iconIndex == iconIndex &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.isVisible == isVisible;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        iconIndex.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        isVisible.hashCode;
  }

  StampModel copyWith({
    String? name,
    int? iconIndex,
    bool? isVisible,
  }) {
    StampModel stampModel = StampModel(
      name: name ?? this.name,
      iconIndex: iconIndex ?? this.iconIndex,
      isVisible: isVisible ?? this.isVisible,
    );
    stampModel.id = id;
    stampModel.createdAt = createdAt;

    return stampModel;
  }
}
