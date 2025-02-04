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
  static const int expensiveModelHiveId = 10;
  static const int categoryModelHiveId = 11;

  static const String petModelBox = 'pets';
  static const String settingModelBox = 'settings';
  static const String stampModelBox = 'stamps';
  static const String todoModelBox = 'todos';
  static const String nutritionModelModelBox = 'nutritions';
  static const String expensiveModelModelBox = 'expensives';
  static const String categoryModelModelBox = 'categories';
  static const String groceriesModelModelBox = 'groceries';
  static const String lastPetIndexKey = 'lastPetIndex';
  static const String lastBottomTapIndexKey = 'lastBottomTapIndex';
  static const String lastNutritionBottomPageIndexKey =
      'lastNutritionBottomPageIndex';

  static const int countOfStampIcon = 16;

  static List<GroceriesModel> defaultgroceriesModels = [
    GroceriesModel(name: AppString.riceText.tr, kcalPerGram: 130, gram: 100),
    GroceriesModel(name: AppString.potatoText.tr, kcalPerGram: 67, gram: 100),
    GroceriesModel(
        name: AppString.sweetPotatoText.tr, kcalPerGram: 131.9, gram: 100),
    GroceriesModel(
        name: AppString.chickenbreastText.tr, kcalPerGram: 26.1, gram: 100),
  ];

  static List<String> defaultCategoryStringList = [
    AppString.foodExpenses.tr,
    AppString.beautyExpenses.tr,
    AppString.hospitalExpenses.tr,
    AppString.entertainmentExpenses.tr,
    AppString.lifeExpenses.tr,
  ];
}
