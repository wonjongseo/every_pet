import 'dart:developer';

import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/nutrition/widgets/body_navigation.dart';
import 'package:every_pet/view/nutrition/widgets/handmade_body.dart';
import 'package:every_pet/view/nutrition/widgets/maker_body.dart';
import 'package:every_pet/view/nutrition/widgets/nutrition_screen_header.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("OPEN NutritionScreen");
    Get.put(NutritionController());
    return GetBuilder<PetsController>(builder: (petcontroller) {
      PetModel pet = petcontroller.pets![petcontroller.petPageIndex];

      return GetBuilder<NutritionController>(builder: (controller) {
        controller.initPetsNutrion(pet);
        return GestureDetector(
          onTap: controller.clearFocusNode,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width10 / 2),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NutritionScreenHeader(pet: pet),
                  const BodyNavigation(),
                  SizedBox(height: Responsive.height10),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width20,
                      vertical: Responsive.height10,
                    ),
                    child: controller.pageIndex == 0
                        ? const MakerBody()
                        : const HandmadeBody(),
                  ),
                  SizedBox(height: Responsive.height10),
                  CustomButton(
                    label: AppString.saveText.tr,
                    onTap: () {
                      controller.onClickSaveBtn(petcontroller, pet);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
