import 'package:every_pet/common/admob/interstitial_manager.dart';
import 'package:every_pet/common/theme/light_theme.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/controllers/image_path_controller.dart';
import 'package:every_pet/controllers/main_controller.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/features/todos/screen/add_detail_todo_screen.dart';
import 'package:every_pet/init_hive.dart';
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
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  InterstitialManager.instance.configure(
      maxPerDay: 10000, // 3,
      showChance: 0.65, // 0.35,
      cooldownMinutes: 15 // 5,
      );

  InterstitialManager.instance.preload();

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
        SettingRepository.getString(AppConstant.settingLanguageKey);

    setState(() {
      if (systemLanguage == null || systemLanguage!.isEmpty) {
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
            initialBinding: InitialBinding(),
            fallbackLocale: const Locale('ko', 'KR'),
            home: const SplashScreen(),
            getPages: [
              GetPage(
                  name: EditDetailTodoScreen.name,
                  page: () => const EditDetailTodoScreen())
            ],
          );
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImagePathController());
    Get.put(MainController(), permanent: true);
    // Get.put(ImagePathController());
    // Get.lazyPut(() => PetsController(), fenix: true);
    Get.lazyPut(() => TodoController(), fenix: true);
    Get.lazyPut(() => NutritionController(), fenix: true);
  }
}
