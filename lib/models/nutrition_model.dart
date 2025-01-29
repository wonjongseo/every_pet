import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/handmade_model.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/view/nutrition/widgets/handmake_body.dart';

part 'nutrition_model.g.dart';

@HiveType(typeId: AppConstant.nutritionModelHiveId)
class NutritionModel {
  @HiveField(0)
  MakerModel? makerModel;

  @HiveField(1)
  HandmadeModel? handmadeModel;

  @HiveField(2)
  late String id;

  @HiveField(3)
  late DateTime createdAt;

  NutritionModel({
    this.makerModel,
    this.handmadeModel,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    createdAt = DateTime.now();
  }

  @override
  String toString() {
    return 'NutritionModel(makerModel: $makerModel, handmadeModel: $handmadeModel, id: $id, createdAt: $createdAt)';
  }
}
