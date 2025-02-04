import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/view/nutrition/widgets/nutrition_screen_header.dart';
import 'package:every_pet/view/nutrition/widgets/nutrition_screen_navigation.dart';
import 'package:every_pet/view/nutrition/widgets/handmake_body.dart';
import 'package:every_pet/view/nutrition/widgets/maker_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NutritionController>(builder: (controller) {
      return GetBuilder<PetsController>(builder: (petsController) {
        PetModel pet = petsController.pets![petsController.petPageIndex];

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.height10,
              horizontal: Responsive.width20,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Card(child: NutritionScreenHeader(pet: pet)),
                      Divider(height: Responsive.height20),
                      FoodScreenNavigation(
                        foodType: controller.bottomPageIndex == 0
                            ? NUTRITION_TYPE.DRY
                            : NUTRITION_TYPE.MANUL,
                        onChanged: controller.onTapBottomNavigation,
                      )
                    ],
                  ),
                  if (controller.pageController != null)
                    Container(
                      margin: EdgeInsets.only(top: Responsive.height10),
                      constraints: BoxConstraints(
                        minHeight: Responsive.height10 * 25,
                        maxHeight: Responsive.height10 * 25,
                      ),
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return MakerBody();
                          } else
                            return HandmadeBody();
                        },
                      ),
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

enum NUTRITION_TYPE { DRY, MANUL }
