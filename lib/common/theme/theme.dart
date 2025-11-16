import 'package:every_pet/common/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

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
    color: Colors.grey[800],
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
