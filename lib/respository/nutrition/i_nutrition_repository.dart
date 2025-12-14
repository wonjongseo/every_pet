import 'package:every_pet/models/nutrition_model.dart';

abstract class INutritionRepository {
  Future<void> saveNutrition(NutritionModel nutritionModel);

  Future<List<NutritionModel>> getNutrtions();
}
