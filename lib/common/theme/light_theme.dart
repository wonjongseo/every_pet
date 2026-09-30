import 'package:every_pet/common/extension/custom_theme_extension.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme(String systemLanguage) {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: ThemeData.light().textTheme.apply(
        fontFamily:
            systemLanguage.contains('ja') ? "ZenMaruGothic" : "CookieRunFont"),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    extensions: [CustomThemeExtension.lightMode],
    cardTheme: const CardThemeData(elevation: 2),
    appBarTheme: const AppBarTheme(
      // backgroundColor: AppColors.primaryColor,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
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
    iconButtonTheme: const IconButtonThemeData(),
    tabBarTheme: const TabBarThemeData(
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
      foregroundColor: AppColors.primaryColor,
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
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.backgroundLight,
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
      thumbColor: WidgetStatePropertyAll(Color(0xFF83939C)),
      trackColor: WidgetStatePropertyAll(Color(0xFFDADFE2)),
    ),
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(color: Colors.grey[700]!),
      overlayColor: WidgetStateProperty.all(Colors.red),
      checkColor: WidgetStateProperty.all(AppColors.primaryColor),
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.grey[200];
          }
          return Colors.white;
        },
      ),
    ),

    // radioTheme: RadioThemeData(
    //   fillColor: MaterialStateProperty.all(
    //     AppColors.primaryColor,
    //   ),
    // ),
  );
}

ThemeData darkTheme(String systemLanguage) {
  final ThemeData base = ThemeData.dark();

  return base.copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily:
              systemLanguage.contains('ja') ? "ZenMaruGothic" : "CookieRunFont",
        ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    extensions: [CustomThemeExtension.darkMode],
    cardTheme: const CardThemeData(
      elevation: 2,
      color: AppColors.greyBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(),
    tabBarTheme: const TabBarThemeData(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      unselectedLabelColor: AppColors.greyDark,
      labelColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenDark,
        foregroundColor: AppColors.white,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.greyBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.greyBackground,
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
      tileColor: AppColors.greyBackground,
      textColor: Colors.white,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(Color(0xFF83939C)),
      trackColor: WidgetStatePropertyAll(Color(0xFF3A4A52)),
    ),
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: Colors.grey),
      overlayColor: WidgetStateProperty.all(Colors.white24),
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return Colors.transparent;
        },
      ),
    ),
    // 필요하면 주석 해제해서 라디오 버튼 색도 맞출 수 있음
    // radioTheme: RadioThemeData(
    //   fillColor: MaterialStateProperty.all(
    //     AppColors.primaryColor,
    //   ),
    // ),
  );
}
