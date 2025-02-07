import 'dart:developer';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/respository/category_repository.dart';
import 'package:every_pet/respository/groceries_repository.dart';
import 'package:every_pet/respository/stamp_repository.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late PetsController petsController;
  @override
  void onReady() async {
    super.onReady();

    await initDefaultDatas(); // don't swap to petsController = Get.put(PetsController());
    petsController = Get.put(PetsController());

    navigate();
  }

  Future<void> initDefaultDatas() async {
    StampRepository stampRepository = StampRepository();

    if ((await stampRepository.getStamps()).isEmpty) {
      log('add default stamps datas to local db');
      for (var stamp in AppConstant.defaultStampModels) {
        await stampRepository.saveStamp(stamp);
      }
    }
    GroceriesRepository groceriesRepository = GroceriesRepository();

    if ((await groceriesRepository.getGroceries()).isEmpty) {
      log('add default groceries datas to local db');
      for (var grocery in AppConstant.defaultgroceriesModels) {
        await groceriesRepository.saveGrocery(grocery);
      }
    }
    CategoryRepository categoryRepository = CategoryRepository();
    if ((await categoryRepository.getCategorys()).isEmpty) {
      log('add default cagetory datas to local db');
      for (var category in AppConstant.defaultCategoryStringList) {
        await categoryRepository.saveCategory(category);
      }
    }
  }

  void navigate() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // 네비게이션 호출 전에 약간 대기
    if (!petsController.hasPets) {
      Get.off(() => EnrollScreen(isFirst: true));
    } else {
      Get.off(() => const MainScreen());
      return;
    }
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImagePath.bisyon,
        ),
      ),
    );
  }
}
