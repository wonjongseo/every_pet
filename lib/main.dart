import 'package:every_pet/common/theme/light_theme.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/cat_model.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/handmade_model.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/models/todo_model.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Every Pets',
      theme: lightTheme(),
      // darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      home: const SplashScreen(),
    );
  }
}

//flutter pub run build_runner build

//  /var/mobile/Containers/Data/Application/47AF36D6-3213-4753-90E5-97F29322EDF7/Documents/コマ.png

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
}
