import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyNavigation extends StatelessWidget {
  const BodyNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: Responsive.width15),
            decoration: BoxDecoration(
              border: controller.pageIndex == index
                  ? const Border(
                      bottom: BorderSide(
                        color: AppColors.primaryColor,
                        width: 3,
                      ),
                    )
                  : null,
            ),
            child: TextButton(
              onPressed: () => controller.changeBody(index),
              child: Text(
                index == 0
                    ? AppString.makterText.tr
                    : AppString.handmadeTextTr.tr,
                style: TextStyle(
                  fontSize: controller.pageIndex == index ? 18 : 16,
                  fontWeight: controller.pageIndex == index
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
