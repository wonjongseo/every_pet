import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:every_pet/view/nutrition/widgets/handmake_body.dart';
import 'package:every_pet/view/nutrition/widgets/maker_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class NutritionController extends GetxController {
  NUTRITION_TYPE foodType = NUTRITION_TYPE.DRY;

  int bottomPageIndex = 0;

  PageController? pageController;

  List<Widget> bodys = [];
  void onTapBottomNavigation(NUTRITION_TYPE? nutritionType) {
    if (nutritionType == null) return;

    foodType = nutritionType;

    update();

    if (foodType == NUTRITION_TYPE.DRY) {
      bottomPageIndex = NUTRITION_TYPE.DRY.index;
    } else {
      bottomPageIndex = NUTRITION_TYPE.MANUL.index;
    }

    pageController!.animateToPage(
      bottomPageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    SettingRepository.setInt(
      SettingKey.lastNutritionBottomPageIndex,
      bottomPageIndex,
    );
  }

  @override
  void onInit() async {
    super.onInit();
    bottomPageIndex =
        await SettingRepository.getInt(SettingKey.lastNutritionBottomPageIndex);

    pageController = PageController(initialPage: bottomPageIndex);
    foodType = NUTRITION_TYPE.values[bottomPageIndex];

    setBodys();
    update();
  }

  void setBodys() {
    bodys.add(MakerBody());
    bodys.add(HandmadeBody());
  }

  void onPageChanged(value) {
    bottomPageIndex = value;
    update();
  }
}
