import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/respository/nutrition/i_nutrition_repository.dart';
import 'package:hive/hive.dart';

class NutritionRepository extends INutritionRepository {
  @override
  Future<void> saveNutrition(NutritionModel nutritionModel) async {
    var box =
        await Hive.openBox<NutritionModel>(AppConstant.nutritionModelModelBox);

    await box.put(nutritionModel.id, nutritionModel);

    print('nutrition saved');
  }

  @override
  Future<List<NutritionModel>> getNutrtions() async {
    var box =
        await Hive.openBox<NutritionModel>(AppConstant.nutritionModelModelBox);

    return box.values.toList();
  }
}
