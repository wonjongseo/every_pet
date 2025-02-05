import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/handmade_model.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/calculate_kcal/calculate_kcal_screen.dart';
import 'package:every_pet/view/new_nutrition/new_nutrition_screen.dart';
import 'package:every_pet/view/nutrition/widgets/nutrition_screen_header.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NutritionController());
    return GetBuilder<PetsController>(builder: (petcontroller) {
      PetModel pet = petcontroller.pets![petcontroller.petPageIndex];

      return GetBuilder<NutritionController>(builder: (controller) {
        controller.initPetsNutrion(pet);
        return Column(
          children: [
            NutritionScreenHeader(pet: pet),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: Responsive.width10),
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
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                    ),
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
            ),
            SizedBox(height: Responsive.height10),
            if (controller.pageIndex == 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      focusNode: controller.focusNode1,
                      autoFocus: true,
                      controller: controller.teController1,
                      hintText: AppString.makterText.tr,
                    ),
                    SizedBox(height: Responsive.height10),
                    CustomTextField(
                      controller: controller.teController2,
                      hintText: AppString.numberOfGivenText.tr,
                      sufficIcon: Text(AppString.numberOfGivenSufficText.tr),
                    ),
                    SizedBox(height: Responsive.height10),
                    CustomTextField(
                      controller: controller.teController3,
                      hintText: AppString.onceText.tr,
                      sufficIcon: Text('g'),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      focusNode: controller.focusNode2,
                      autoFocus: true,
                      controller: controller.teController4,
                      hintText: AppString.amountGivenGramText.tr,
                      sufficIcon: const Text('g'),
                      maxLines: 1,
                    ),
                    SizedBox(height: Responsive.height10),
                    CustomTextField(
                      controller: controller.teController5,
                      hintText: AppString.vegetableText.tr,
                      sufficIcon: const Text('g'),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: Responsive.height10),
                    CustomTextField(
                      controller: controller.teController6,
                      hintText: AppString.proteinText.tr,
                      sufficIcon: const Text('g'),
                      maxLines: 1,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          Get.to(() => const CalculateKcalScreen());
                        },
                        child: Text(AppString.calculateKcalText.tr),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: Responsive.height10),
            CustomButton(
              label: AppString.saveText.tr,
              onTap: () => controller.onClickSaveBtn(petcontroller, pet),
            )
          ],
        );
      });
    });
  }
}
