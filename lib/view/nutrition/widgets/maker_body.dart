import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/nutrition_controller.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/maker_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakerBody extends StatelessWidget {
  MakerBody({super.key});

  late TextEditingController makerNameEditingController;
  late TextEditingController givenGramEditingController;
  late TextEditingController givenGramOnceEditingController;

  NutritionController nutritionController = Get.find<NutritionController>();

  void initMakerTextEditingController(PetModel pet) {
    String makerName = '';
    String givenGramString = '';
    String givenGramOnceString = '';

    if (pet.nutritionModel != null && pet.nutritionModel!.makerModel != null) {
      makerName = pet.nutritionModel!.makerModel!.makerName;
      givenGramString =
          pet.nutritionModel!.makerModel!.givenCountPerDay.toString();
      givenGramOnceString =
          pet.nutritionModel!.makerModel!.givenGramOnce.toString();
    }

    makerNameEditingController = TextEditingController(text: makerName);
    givenGramEditingController = TextEditingController(text: givenGramString);
    givenGramOnceEditingController =
        TextEditingController(text: givenGramOnceString);
  }

  void saveMaker() async {
    String makerName = makerNameEditingController.text;
    String givenCountPerDayString = givenGramEditingController.text;
    String givenGramOnceString = givenGramOnceEditingController.text;

    if ((makerName.isEmpty || makerName == "") &&
        (givenCountPerDayString.isEmpty || givenCountPerDayString == "") &&
        (givenGramOnceString.isEmpty || givenGramOnceString == "")) {
      return;
    }

    int givenCountPerDay = 0;
    double givenGramOnce = 0.0;

    if (givenCountPerDayString.isNotEmpty && givenCountPerDayString != '') {
      givenCountPerDay = int.parse(givenCountPerDayString);
    }
    if (givenGramOnceString.isNotEmpty && givenGramOnceString != '') {
      givenGramOnce = double.parse(givenGramOnceString);
    }
    MakerModel makerModel = MakerModel(
      makerName: makerName,
      givenCountPerDay: givenCountPerDay,
      givenGramOnce: givenGramOnce,
    );
    nutritionController.saveMaker(petModel, makerModel);
  }

  late PetModel petModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(builder: (petsController) {
      petModel = petsController.pets![petsController.petPageIndex];
      initMakerTextEditingController(petModel);

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
                  controller: makerNameEditingController,
                  hintText: AppString.makterText.tr,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.height10 * .8,
                  horizontal: Responsive.width16,
                ),
                child: CustomTextField(
                  controller: givenGramOnceEditingController,
                  hintText: AppString.numberOfGivenText.tr,
                  sufficIcon: Text(
                    AppString.numberOfGivenSufficText.tr,
                  ),
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
                  controller: givenGramEditingController,
                  hintText: AppString.onceText.tr,
                  sufficIcon: Text('g'),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                saveMaker();
              },
              child: Text('保存'))
        ],
      );
    });
  }
}
