import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakerBody extends StatelessWidget {
  const MakerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NutritionController controller = Get.find<NutritionController>();
    return Column(
      children: [
        CustomTextField(
          focusNode: controller.focusNode1,
          autoFocus: true,
          controller: controller.teController1,
          hintText: AppString.makterText.tr,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          controller: controller.teController2,
          hintText: AppString.numberOfGivenText.tr,
          sufficIcon: Text(AppString.numberOfGivenSufficText.tr),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          controller: controller.teController3,
          hintText: '1${AppString.countText.tr}',
          keyboardType: TextInputType.number,
          sufficIcon: const Text('g'),
        ),
      ],
    );
  }
}
