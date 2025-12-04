import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:every_pet/view/expensive/expensive_screen.dart';
import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:every_pet/view/setting/setting_screen.dart';
import 'package:every_pet/view/todo/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();
  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

  List<Widget> body = const [
    TodoScreen(),
    NutritionScreen(),
    ExpensiveScreen(),
    SettingScreen()
  ];

  PersistentBottomSheetController? bottomSheetController;
  final bottomTapIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    bottomTapIndex.value =
        SettingRepository.getInt(AppConstant.lastBottomTapIndexKey) ?? 0;
  }

  void closeBottomSheet() {
    if (bottomSheetController != null) {
      bottomSheetController!.close();
      bottomSheetController = null;
    }
  }

  void goToEnrollScreen() async {
    closeBottomSheet();
    // Get.put(EnrollController());

    // Get.to(() => EnrollScreen(isFirst: _pets!.isEmpty));
    Get.to(() => EnrollScreen(isFirst: false));
  }

  void onTapBottomBar(value) async {
    if (value != 0) {
      closeBottomSheet();
    }

    bottomTapIndex.value = value;

    SettingRepository.setInt(
        AppConstant.lastBottomTapIndexKey, bottomTapIndex.value);
  }
}
