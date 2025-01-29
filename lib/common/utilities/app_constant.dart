import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:get/get.dart';

class AppConstant {
  static const int petModelHiveId = 0;
  static const int dogModelHiveId = 1;
  static const int genderTypeHiveId = 2;
  static const int stampModelHiveId = 3;
  static const int todoModelHiveId = 4;
  static const int catModelHiveId = 5;
  static const int nutritionModelHiveId = 6;
  static const int makerModelHiveId = 7;
  static const int handmadeModelHiveId = 8;
  static const int groceriesModelHiveId = 9;

  static const String petModelBox = 'pets';
  static const String settingModelBox = 'settings';
  static const String stampModelBox = 'stamps';
  static const String todoModelBox = 'todos';
  static const String nutritionModelModelBox = 'nutritions';
  static const String lastPetIndexKey = 'lastPetIndex';
  static const String lastBottomTapIndexKey = 'lastBottomTapIndex';
  static const String lastNutritionBottomPageIndexKey =
      'lastNutritionBottomPageIndex';

  static const int countOfStampIcon = 16;

  static List<GroceriesModel> groceriesModels = [
    GroceriesModel(name: AppString.riceText.tr, kcalPer100g: 130, gram: 100),
    GroceriesModel(name: AppString.potatoText.tr, kcalPer100g: 67, gram: 100),
    GroceriesModel(
        name: AppString.sweetPotatoText.tr, kcalPer100g: 131.9, gram: 100),
    GroceriesModel(
        name: AppString.chickenbreastText.tr, kcalPer100g: 26.1, gram: 100),
  ];
}
