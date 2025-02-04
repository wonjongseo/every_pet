import 'dart:developer';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:every_pet/respository/category_repository.dart';
import 'package:every_pet/respository/groceries_repository.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late PetsController petsController;
  @override
  void onInit() async {
    super.onInit();
    petsController = Get.put(PetsController());
    await initDefaultData();
    navigate();
  }

  Future<void> initDefaultData() async {
    CategoryRepository categoryRepository = CategoryRepository();
    if ((await categoryRepository.getCategorys()).isEmpty) {
      log('add default cagetory datas to local db');
      for (var category in AppConstant.defaultCategoryStringList) {
        await categoryRepository
            .saveCategory(ProductCategoryModel(name: category));
      }
    }
    GroceriesRepository groceriesRepository = GroceriesRepository();

    if ((await groceriesRepository.getGroceries()).isEmpty) {
      log('add default groceries datas to local db');
      for (var grocery in AppConstant.defaultgroceriesModels) {
        await groceriesRepository.saveGrocery(grocery);
      }
    }
  }

  void navigate() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // 네비게이션 호출 전에 약간 대기
    if (petsController.pets == null) {
      return;
    } else if (petsController.pets!.isEmpty) {
      // Get.put(EnrollController());
      Get.off(() => EnrollScreen(isFirst: true));
    } else {
      Get.off(() => const MainScreen());
      return;
    }
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // late PetsController petsController;

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
