import 'package:every_pet/common/extension/custom_theme_extension.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: ThemeData.light().textTheme.apply(fontFamily: "ZenMaruGothic"),
    backgroundColor: AppColors.backgroundDark,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    extensions: [
      CustomThemeExtension.lightMode,
    ],
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greenLight,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      unselectedLabelColor: Color(0xFFB3D9D2),
      labelColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenLight,
        foregroundColor: AppColors.backgroundLight,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      // backgroundColor: AppColors.greenLight,
      foregroundColor: AppColors.greenLight,
      splashFactory: NoSplash.splashFactory,
      elevation: 0,
      shadowColor: Colors.transparent,
    )),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.backgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogBackgroundColor: AppColors.backgroundLight,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenDark,
      foregroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.greenDark,
      tileColor: AppColors.backgroundLight,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Color(0xFF83939C)),
      trackColor: MaterialStatePropertyAll(Color(0xFFDADFE2)),
    ),
  );
}
