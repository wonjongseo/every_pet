import 'package:every_pet/common/theme/dark_theme.dart';
import 'package:every_pet/common/theme/light_theme.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/cat_model.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:every_pet/sample_pages/basic_example.dart';
import 'package:every_pet/sample_pages/event_example.dart';
import 'package:every_pet/sample_pages/multi_example.dart';
import 'package:every_pet/sample_pages/range_example.dart';
import 'package:every_pet/view/calendar/calendar_screen.dart';
import 'package:every_pet/view/kcal_caculate_screen.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:every_pet/view/profile_screen.dart';
import 'package:every_pet/view/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(PetModelAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(DogModelAdapter());
  }

  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(GENDERTYPEAdapter());
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(StampModelAdapter());
  }
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  if (!Hive.isAdapterRegistered(5)) {
    Hive.registerAdapter(CatModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PetsController());
    return GetMaterialApp(
      title: 'Every Pets',
      theme: lightTheme(),
      // darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      translations: AppTranslations(),
      // locale: Get.deviceLocale,
      locale: const Locale('ja', 'JP'),
      fallbackLocale: const Locale('en', 'US'),
      home: GetBuilder<PetsController>(
        builder: (controller) {
          if (controller.pets == null) {
            return Scaffold(
              body: Container(
                child: Text('LODING'),
              ),
            );
          } else if (controller.pets!.isEmpty) {
            return const WelcomeScreen();
          } else {
            return const MainScreen();
          }
        },
      ),
    );
  }
}

//flutter pub run build_runner build

//  /var/mobile/Containers/Data/Application/47AF36D6-3213-4753-90E5-97F29322EDF7/Documents/コマ.png
