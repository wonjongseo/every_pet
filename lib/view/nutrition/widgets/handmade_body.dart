import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/view/calculate_kcal/calculate_kcal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HandmadeBody extends StatelessWidget {
  const HandmadeBody({super.key});

  @override
  Widget build(BuildContext context) {
    NutritionController controller = Get.find<NutritionController>();
    return Column(
      children: [
        CustomTextField(
          focusNode: controller.focusNode1,
          controller: controller.teController4,
          hintText: AppString.amountGivenGramText.tr,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          sufficIcon: Text('1${AppString.dayText.tr}/ g'),
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          focusNode: controller.focusNode2,
          controller: controller.teController5,
          hintText: AppString.vegetableText.tr,
          sufficIcon: Text('1${AppString.dayText.tr}/ g'),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          focusNode: controller.focusNode3,
          controller: controller.teController6,
          hintText: AppString.proteinText.tr,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          sufficIcon: Text('1${AppString.dayText.tr}/ g'),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Get.to(() => const CalculateKcalScreen());
            },
            child: Text(AppString.calculateKcalText.tr),
          ),
        ),
      ],
    );
  }
}
