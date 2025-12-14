import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find<SettingController>();
  final Rx<bool> _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() async {
    super.onInit();
    await _getIsDarkMode();
  }

  Future<void> toggleDarkMode(v) async {
    _isDarkMode.value = v;
    ThemeMode themeMode = _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode);

    await SettingRepository.setBool(AppConstant.isDarkMode, _isDarkMode.value);
  }

  Future<void> _getIsDarkMode() async {
    final isDarkMode = SettingRepository.getBool(AppConstant.isDarkMode);
    if (isDarkMode == null) {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      final deviceIsDark = brightness == Brightness.dark;
      await toggleDarkMode(deviceIsDark);
    }
    _isDarkMode.value = SettingRepository.getBool(AppConstant.isDarkMode)!;
  }

  Color get realBlackOrWhite =>
      _isDarkMode.value ? AppColors.white : AppColors.backgroundDark;

  Color get mainColor =>
      _isDarkMode.value ? AppColors.primaryColor : AppColors.primaryColor;

  Color get mainBordColor =>
      _isDarkMode.value ? AppColors.primaryColor : AppColors.primaryColor;

  Color get blackOrWhite =>
      _isDarkMode.value ? AppColors.backgroundDark : Colors.white;

  Color get nonSelectedColor => _isDarkMode.value
      ? Colors.white.withOpacity(.8)
      : AppColors.backgroundDark.withOpacity(0.5);
}
