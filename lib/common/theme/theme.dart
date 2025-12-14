import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// Color get blackOrWhite =>
//     Get.isDarkMode ? AppColors.backgroundDark : Colors.white;
// Color get textBlackOrWhite =>
//     Get.isDarkMode ? AppColors.backgroundDark : Colors.white;

TextStyle get subHeadingStyle {
  return TextStyle(
    fontSize: Responsive.width10 * 1.6,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  );
}

TextStyle get headingStyle {
  return TextStyle(
    fontSize: Responsive.width10 * 1.7,
    fontWeight: FontWeight.w600,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  );
}

TextStyle get activeHintStyle {
  return TextStyle(
    fontSize: Responsive.width14,
    fontWeight: FontWeight.w100,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  );
}

TextStyle get contentStyle {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: Responsive.width15,
  );
}

TextStyle get subTitleStyle {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
  );
}
