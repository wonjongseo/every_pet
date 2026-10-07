import 'package:every_pet/common/bindings/initial_binding.dart';
import 'package:every_pet/common/routes/app_route.dart';
import 'package:every_pet/common/admob/interstitial_manager.dart';
import 'package:every_pet/common/theme/light_theme.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';

import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/init_hive.dart';
import 'package:every_pet/view/setting/controller/setting_controller.dart';

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
      showChance: 0.35, // 0.35,
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
    final controller = Get.put(SettingController(), permanent: true);
    return systemLanguage == null
        ? Container()
        : GetMaterialApp(
            title: 'Every Pets',
            theme: lightTheme(systemLanguage!),
            darkTheme: darkTheme(systemLanguage!),
            debugShowCheckedModeBanner: false,
            themeMode: controller.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            translations: AppTranslations(),
            locale: Locale(systemLanguage!),
            initialBinding: InitialBinding(),
            fallbackLocale: const Locale('ko', 'KR'),
            initialRoute: SplashScreen.name,
            getPages: AppRouter.getPages,
          );
  }
}
