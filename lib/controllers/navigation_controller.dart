import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/expensive/expensive_screen.dart';
import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:every_pet/view/todo/todo_screen.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  ScrollController scrollController = ScrollController();
  int petPageIndex = 0;
  PersistentBottomSheetController? bottomSheetController;
  PetsController petsController = Get.find<PetsController>();

  int bottomTapIndex = 0;

  List<Widget> body = const [
    TodoScreen(),
    NutritionScreen(),
    ExpensiveScreen(),
    ProfileScreen()
  ];

  @override
  void onInit() async {
    super.onInit();
    petPageIndex = await SettingRepository.getInt(AppConstant.lastPetIndexKey);
    bottomTapIndex =
        await SettingRepository.getInt(AppConstant.lastBottomTapIndexKey);
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  void closeBottomSheet() {
    if (bottomSheetController != null) {
      bottomSheetController!.close();
      bottomSheetController = null;
    }
  }

  void goToEnrollScreen() async {
    closeBottomSheet();
    Get.to(() => EnrollScreen(isFirst: false));
  }

  void onTapTopBar(int index) {
    petPageIndex = index;

    update();

    SettingRepository.setInt(AppConstant.lastPetIndexKey, petPageIndex);
    if (bottomTapIndex == 3) {
      scrollGoToTop();
    }
  }

  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
      curve: Curves.easeInOut, // 애니메이션 곡선
    );
  }

  void onTapBottomBar(value) async {
    if (value != 0) {
      closeBottomSheet();
    }
    if (value == 1) {
      // nutritionController.bottomPageIndex = await SettingRepository.getInt(
      //   AppConstant.lastNutritionBottomPageIndexKey);
    }

    bottomTapIndex = value;

    update();

    SettingRepository.setInt(AppConstant.lastBottomTapIndexKey, bottomTapIndex);
  }
}
