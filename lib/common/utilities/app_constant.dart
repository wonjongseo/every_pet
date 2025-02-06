import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:every_pet/models/stamp_model.dart';
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
  static const String settingLanguageKey = 'settingLanguage';
  static const String lastPetIndexKey = 'lastPetIndex';
  static const String lastBottomTapIndexKey = 'lastBottomTapIndex';
  static const String lastNutritionBottomPageIndexKey =
      'lastNutritionBottomPageIndex';

  static const String countOfReiveRequestionKey = 'countOfReiveRequestion';
  static const String hasReviewedKey = 'hasReviewed';

  static const int countOfStampIcon = 16;

  static const String editCategorySign = "-@+편집+@-";

  static const int invalidNumber = -9192939;

  static List<GroceriesModel> defaultgroceriesModels = [
    GroceriesModel(
      name: AppString.riceText.tr,
      kcalPer100g: 148,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.potatoText.tr,
      kcalPer100g: 86,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.sweetPotatoText.tr,
      kcalPer100g: 114,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.chickenbreastText.tr,
      kcalPer100g: 109,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.carrotText.tr,
      kcalPer100g: 34,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.bananaText.tr,
      kcalPer100g: 93,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.appleText.tr,
      kcalPer100g: 52,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.tara.tr,
      kcalPer100g: 77,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.salmonText.tr,
      kcalPer100g: 139.9,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.cucumberText.tr,
      kcalPer100g: 11,
      gram: 100,
    ),
  ];

  static List<ProductCategoryModel> defaultCategoryStringList = [
    ProductCategoryModel(name: AppString.foodExpenses.tr),
    ProductCategoryModel(name: AppString.beautyExpenses.tr),
    ProductCategoryModel(name: AppString.hospitalExpenses.tr),
    ProductCategoryModel(name: AppString.entertainmentExpenses.tr),
    ProductCategoryModel(name: AppString.lifeExpenses.tr),
  ];

  static List<StampModel> defaultStampModels = [
    StampModel(
      name: AppString.stamp1Tr.tr,
      iconIndex: 0,
      isVisible: true,
    ), // 0xFFff9796
    StampModel(
      name: AppString.stamp2Tr.tr,
      iconIndex: 1,
      isVisible: true,
    ), // 0xFF229cff
    StampModel(
      name: AppString.stamp3Tr.tr,
      iconIndex: 2,
      isVisible: true,
    ), // 0xFF56e1ff
    StampModel(
      name: AppString.stamp4Tr.tr,
      iconIndex: 3,
      isVisible: true,
    ), // 0xFFf59b23
    StampModel(
      name: AppString.stamp5Tr.tr,
      iconIndex: 4,
      isVisible: true,
    ), // 0xFFf59b23
    StampModel(
      name: AppString.stamp6Tr.tr,
      iconIndex: 5,
      isVisible: true,
    ), // 0xFF7ec636
    StampModel(
      name: AppString.stamp7Tr.tr,
      iconIndex: 6,
      isVisible: true,
    ), // 0xFFe5b7ff
    StampModel(
      name: AppString.stamp8Tr.tr,
      iconIndex: 7,
      isVisible: true,
    ), // 0xFFdbff85
  ];
}
