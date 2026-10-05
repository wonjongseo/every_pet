import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find<SettingController>();
  final Rx<bool> _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  final RxString _backgroundImagePath = AppImagePath.bisyon.obs;
  final RxString _backgroundImageSource =
      AppConstant.backgroundImageSourceAsset.obs;
  final RxDouble _backgroundOpacity = .2.obs;

  String get backgroundImagePath => _backgroundImagePath.value;
  String get backgroundImageSource => _backgroundImageSource.value;
  double get backgroundOpacity => _backgroundOpacity.value;
  bool get isCustomBackground =>
      _backgroundImageSource.value == AppConstant.backgroundImageSourceFile;

  @override
  void onInit() async {
    super.onInit();
    await _getIsDarkMode();
    _getBackgroundSetting();
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

  void _getBackgroundSetting() {
    _backgroundImagePath.value =
        SettingRepository.getString(AppConstant.backgroundImagePathKey) ??
            AppImagePath.bisyon;
    _backgroundImageSource.value =
        SettingRepository.getString(AppConstant.backgroundImageSourceKey) ??
            AppConstant.backgroundImageSourceAsset;
    _backgroundOpacity.value =
        SettingRepository.getDouble(AppConstant.backgroundOpacityKey) ?? .2;
  }

  Future<void> updateBackground({
    required String imagePath,
    required String imageSource,
    required double opacity,
  }) async {
    _backgroundImagePath.value = imagePath;
    _backgroundImageSource.value = imageSource;
    _backgroundOpacity.value = opacity.clamp(0, 1);

    await SettingRepository.setString(
      AppConstant.backgroundImagePathKey,
      _backgroundImagePath.value,
    );
    await SettingRepository.setString(
      AppConstant.backgroundImageSourceKey,
      _backgroundImageSource.value,
    );
    await SettingRepository.setDouble(
      AppConstant.backgroundOpacityKey,
      _backgroundOpacity.value,
    );
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
