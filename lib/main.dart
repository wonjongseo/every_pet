import 'package:every_pet/common/theme/light_theme.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/cat_model.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/expensive_model.dart';
import 'package:every_pet/models/handmade_model.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:every_pet/respository/setting_repository.dart';

import 'package:every_pet/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  initializeDateFormatting();
  await initHive();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? systemLanguage;

  @override
  void initState() {
    super.initState();
    getSystemLanguage();
  }

  void getSystemLanguage() async {
    systemLanguage =
        await SettingRepository.getString(AppConstant.settingLanguageKey);

    setState(() {
      if (systemLanguage!.isEmpty) {
        systemLanguage = Get.deviceLocale.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return systemLanguage == null
        ? Container()
        : GetMaterialApp(
            title: 'Every Pets',
            theme: lightTheme(systemLanguage!),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            translations: AppTranslations(),
            locale: Locale(systemLanguage!),
            fallbackLocale: const Locale('ko', 'KR'),
            home: const SplashScreen(),
          );
  }
}
// Android Command - flutter build appbundle
//flutter pub run build_runner build

//dart run change_app_package_name:main com.wonjongseo.every_pet

Future<void> initHive() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(AppConstant.petModelHiveId)) {
    Hive.registerAdapter(PetModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.dogModelHiveId)) {
    Hive.registerAdapter(DogModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.genderTypeHiveId)) {
    Hive.registerAdapter(GENDERTYPEAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.stampModelHiveId)) {
    Hive.registerAdapter(StampModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.todoModelHiveId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.catModelHiveId)) {
    Hive.registerAdapter(CatModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.makerModelHiveId)) {
    Hive.registerAdapter(MakerModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.handmadeModelHiveId)) {
    Hive.registerAdapter(HandmadeModelAdapter());
  }
  if (!Hive.isAdapterRegistered(AppConstant.nutritionModelHiveId)) {
    Hive.registerAdapter(NutritionModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.expensiveModelHiveId)) {
    Hive.registerAdapter(ExpensiveModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.categoryModelHiveId)) {
    Hive.registerAdapter(ProductCategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AppConstant.groceriesModelHiveId)) {
    Hive.registerAdapter(GroceriesModelAdapter());
  }
}
