import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/view/nutrition/widgets/handmake_body.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: AppConstant.nutritionModelHiveId)
class NutritionModel {
  @HiveField(0)
  MakerModel? makerModel;

  @HiveField(1)
  HandmadeBody? handmadeBody;

  @HiveField(2)
  late String id;

  @HiveField(3)
  late DateTime createdAt;

  NutritionModel({
    this.makerModel,
    this.handmadeBody,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
    createdAt = DateTime.now();
  }
}
