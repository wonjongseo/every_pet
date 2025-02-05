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
          focusNode: controller.focusNode2,
          autoFocus: true,
          controller: controller.teController4,
          hintText: AppString.amountGivenGramText.tr,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          sufficIcon: const Text('g'),
          maxLines: 1,
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          controller: controller.teController5,
          hintText: AppString.vegetableText.tr,
          sufficIcon: const Text('g'),
          maxLines: 1,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          controller: controller.teController6,
          hintText: AppString.proteinText.tr,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          sufficIcon: const Text('g'),
          maxLines: 1,
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
