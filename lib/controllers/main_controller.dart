import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/snackbar_helper.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:every_pet/view/expensive/expensive_screen.dart';
import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:every_pet/view/setting/setting_screen.dart';
import 'package:every_pet/view/todo/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();
  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

  final isLoading = true.obs;

  List<Widget> body = const [
    TodoScreen(),
    NutritionScreen(),
    ExpensiveScreen(),
    SettingScreen()
  ];

  Future<void> getLoadingData() async {
    try {
      everAll([PetsController.to.isLoading], (value) {
        isLoading.value = false;
      });
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('$e');
    }
  }

  PersistentBottomSheetController? bottomSheetController;
  final bottomTapIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    bottomTapIndex.value =
        SettingRepository.getInt(AppConstant.lastBottomTapIndexKey) ?? 0;
  }

  @override
  void onReady() {
    getLoadingData();

    super.onReady();
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
    Get.toNamed(EnrollScreen.name, arguments: false); // TODO
    // Get.to(() => EnrollScreen(isFirst: false));
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
