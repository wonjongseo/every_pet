import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:every_pet/models/stamp_model.dart';

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

  static const int countOfStampIcon = 18;

  static const String editCategorySign = "-@+편집+@-";

  static const int invalidNumber = -9192939;
  static const String isDarkMode = 'isDarkMode';
  static const String backgroundImagePathKey = 'backgroundImagePath';
  static const String backgroundImageSourceKey = 'backgroundImageSource';
  static const String backgroundOpacityKey = 'backgroundOpacity';
  static const String backgroundImageSourceAsset = 'asset';
  static const String backgroundImageSourceFile = 'file';
  static const int dateTimePickerFirstYear = 2010;

  static List<GroceriesModel> defaultgroceriesModels = [
    GroceriesModel(
      name: AppString.riceText,
      kcalPer100g: 148,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.potatoText,
      kcalPer100g: 86,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.sweetPotatoText,
      kcalPer100g: 114,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.chickenbreastText,
      kcalPer100g: 109,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.carrotText,
      kcalPer100g: 34,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.bananaText,
      kcalPer100g: 93,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.appleText,
      kcalPer100g: 52,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.tara,
      kcalPer100g: 77,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.salmonText,
      kcalPer100g: 139.9,
      gram: 100,
    ),
    GroceriesModel(
      name: AppString.cucumberText,
      kcalPer100g: 11,
      gram: 100,
    ),
  ];

  static List<ProductCategoryModel> defaultCategoryStringList = [
    ProductCategoryModel(name: AppString.foodExpenses),
    ProductCategoryModel(name: AppString.beautyExpenses),
    ProductCategoryModel(name: AppString.hospitalExpenses),
    ProductCategoryModel(name: AppString.entertainmentExpenses),
    ProductCategoryModel(name: AppString.lifeExpenses),
  ];

  static List<StampModel> defaultStampModels = [
    StampModel(
      name: AppString.stamp1Tr,
      iconIndex: 0,
      isVisible: true,
    ), // 0xFFff9796
    StampModel(
      name: AppString.stamp2Tr,
      iconIndex: 1,
      isVisible: true,
    ), // 0xFF229cff
    StampModel(
      name: AppString.stamp3Tr,
      iconIndex: 2,
      isVisible: true,
    ), // 0xFF56e1ff
    StampModel(
      name: AppString.stamp4Tr,
      iconIndex: 3,
      isVisible: true,
    ), // 0xFFf59b23
    StampModel(
      name: AppString.stamp5Tr,
      iconIndex: 4,
      isVisible: true,
    ), // 0xFFf59b23
    StampModel(
      name: AppString.stamp6Tr,
      iconIndex: 5,
      isVisible: true,
    ), // 0xFF7ec636
    StampModel(
      name: AppString.stamp7Tr,
      iconIndex: 6,
      isVisible: true,
    ), // 0xFFe5b7ff
    StampModel(
      name: AppString.stamp8Tr,
      iconIndex: 7,
      isVisible: true,
    ), // 0xFFdbff85
  ];
}
