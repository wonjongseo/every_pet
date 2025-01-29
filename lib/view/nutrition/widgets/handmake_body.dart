import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/handmade_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/calculate_kcal/calculate_kcal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HandmadeBody extends StatelessWidget {
  HandmadeBody({super.key});

  late TextEditingController givenGramPerDayEditingController;
  late TextEditingController givenVegetableGramEditingController;
  late TextEditingController givenProteinGramEditingController;

  NutritionController nutritionController = Get.find<NutritionController>();

  void initHandmadeTextEditingController(PetModel petModel) {
    String givenGramPerDayString = '';
    String givenVegetableGramString = '';
    String givenProteinGramString = '';

    if (petModel.nutritionModel != null &&
        petModel.nutritionModel!.handmadeModel != null) {
      givenGramPerDayString =
          petModel.nutritionModel!.handmadeModel!.givenGramPerDay.toString();
      givenVegetableGramString =
          petModel.nutritionModel!.handmadeModel!.givenProteinGram.toString();
      givenProteinGramString =
          petModel.nutritionModel!.handmadeModel!.givenVegetableGram.toString();
    }

    givenGramPerDayEditingController =
        TextEditingController(text: givenGramPerDayString);
    givenVegetableGramEditingController =
        TextEditingController(text: givenVegetableGramString);
    givenProteinGramEditingController =
        TextEditingController(text: givenProteinGramString);
  }

  void saveHandMake(PetModel petModel) async {
    String givenGramPerDayString = givenGramPerDayEditingController.text;
    String givenVegetableGramString = givenVegetableGramEditingController.text;
    String givenProteinGramString = givenProteinGramEditingController.text;

    if ((givenGramPerDayString.isEmpty || givenGramPerDayString == "") &&
        (givenVegetableGramString.isEmpty || givenVegetableGramString == "") &&
        (givenProteinGramString.isEmpty || givenProteinGramString == "")) {
      return;
    }

    double givenGramPerDay = 0.0;
    double givenVegetableGram = 0.0;
    double givenProteinGram = 0.0;
    if (givenGramPerDayString.isNotEmpty && givenGramPerDayString != '') {
      givenGramPerDay = double.parse(givenGramPerDayString);
    }
    if (givenVegetableGramString.isNotEmpty && givenVegetableGramString != '') {
      givenVegetableGram = double.parse(givenVegetableGramString);
    }
    if (givenProteinGramString.isNotEmpty && givenProteinGramString != '') {
      givenProteinGram = double.parse(givenProteinGramString);
    }
    HandmadeModel handmadeModel = HandmadeModel(
      givenGramPerDay: givenGramPerDay,
      givenVegetableGram: givenVegetableGram,
      givenProteinGram: givenProteinGram,
    );
    nutritionController.saveHandMaker(petModel, handmadeModel);
  }

  late PetModel petModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(builder: (petsController) {
      petModel = petsController.pets![petsController.petPageIndex];
      initHandmadeTextEditingController(petModel);
      return Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.height10 * .8,
                  horizontal: Responsive.width16,
                ),
                child: CustomTextField(
                  controller: givenGramPerDayEditingController,
                  hintText: AppString.amountGivenGramText.tr,
                  sufficIcon: const Text('g'),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.height10 * .8,
                  horizontal: Responsive.width16,
                ),
                child: CustomTextField(
                  controller: givenVegetableGramEditingController,
                  hintText: AppString.vegetableText.tr,
                  sufficIcon: const Text('g'),
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.height10 * .8,
                  horizontal: Responsive.width16,
                ),
                child: CustomTextField(
                  controller: givenProteinGramEditingController,
                  hintText: AppString.proteinText.tr,
                  sufficIcon: const Text('g'),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          print('object');
                          saveHandMake(petModel);
                        },
                        child: Text('保存'))),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Get.to(() => CalculateKcalScreen());
                        },
                        child: Text(AppString.calculateKcalText.tr))),
              ],
            ),
          )
        ],
      );
    });
  }
}
