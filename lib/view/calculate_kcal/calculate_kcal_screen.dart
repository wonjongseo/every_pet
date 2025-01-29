import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculateKcalScreen extends StatelessWidget {
  const CalculateKcalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CalculateKcalController());
    return GetBuilder<CalculateKcalController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppString.calculateKcalText.tr),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                right: Responsive.width10,
                left: Responsive.width10,
                top: Responsive.height10,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Responsive.height10,
                      left: Responsive.width10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          text: '食材のカロリー',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Responsive.width18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.groceriesModels.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(Responsive.width10 * .4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GroceryKcalAndGramRow(
                                groceryName:
                                    controller.groceriesModels[index].name,
                                kcalController:
                                    controller.kcalControllers[index],
                                onChangeKcal: (value) =>
                                    controller.updateKcal(value, index),
                                gramController:
                                    controller.gramControllers[index],
                                onChangeGram: (value) => controller.updateGram(
                                  value,
                                  index,
                                ),
                              ),
                            ),
                            SizedBox(width: Responsive.width10),
                            InkWell(
                              onTap: () {
                                controller.onAddBtnClick(
                                  controller.groceriesModels[index],
                                );
                              },
                              child: Image.asset(
                                AppImagePath.circleAddBtn,
                                width: Responsive.width10 * 4,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(height: Responsive.height40),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: Responsive.height10,
                      left: Responsive.width10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: controller.pet.name,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.width22,
                              ),
                            ),
                            TextSpan(
                              text:
                                  controller.pet.genderType == GENDER_TYPE.MALE
                                      ? AppString.sufficMaleText.tr
                                      : AppString.sufficFeMaleTextTr.tr,
                              children: [
                                TextSpan(text: 'の'),
                                TextSpan(
                                  text: '適量カロリー',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Responsive.width18,
                                  ),
                                ),
                                TextSpan(text: 'は'),
                                TextSpan(
                                  text:
                                      '${controller.pet.getDER().toString()}kcal',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Responsive.width20,
                                  ),
                                ),
                                TextSpan(text: 'です。'),
                              ],
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.width15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButton(
                          value: controller.givenCountPerDay,
                          items: const [
                            DropdownMenuItem(value: 1, child: Text('１回')),
                            DropdownMenuItem(value: 2, child: Text('２回')),
                            DropdownMenuItem(value: 3, child: Text('３回')),
                          ],
                          onChanged: controller.changeGivenCountPerDay),
                      SizedBox(width: Responsive.width10),
                      Text('1日/回数')
                    ],
                  ),
                  SizedBox(height: Responsive.height10),
                  Column(
                    children: List.generate(
                        controller.selectedGroceriesModels.length, (index) {
                      return Padding(
                        padding: EdgeInsets.all(Responsive.width10 * .4),
                        child: Row(
                          children: [
                            Expanded(
                              child: GroceryKcalAndGramRow(
                                groceryName: controller
                                    .selectedGroceriesModels[index].name,
                                kcalController:
                                    controller.selectedKcalControllers[index],
                                gramController:
                                    controller.selectedGramControllers[index],
                              ),
                            ),
                            SizedBox(width: Responsive.width10),
                            IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: AppColors.white),
                              onPressed: () {
                                controller.onRemoteBtnClick(index);
                              },
                              icon: Icon(Icons.remove),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }
}

class GroceryKcalAndGramRow extends StatelessWidget {
  const GroceryKcalAndGramRow({
    super.key,
    required this.groceryName,
    required this.kcalController,
    this.onChangeKcal,
    required this.gramController,
    this.onChangeGram,
  });

  final String groceryName;
  final TextEditingController kcalController;
  final Function(String)? onChangeKcal;
  final TextEditingController gramController;
  final Function(String)? onChangeGram;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            groceryName,
            style: TextStyle(
              fontSize: Responsive.width16,
            ),
          ),
        ),
        SizedBox(width: Responsive.width10),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextField(
                  sufficIcon: const Text('kcal'),
                  readOnly: onChangeKcal == null ? true : false,
                  controller: kcalController,
                  onChanged: onChangeKcal,
                ),
              ),
              SizedBox(width: Responsive.width10),
              Expanded(
                child: CustomTextField(
                  onChanged: onChangeGram,
                  readOnly: onChangeGram == null ? true : false,
                  sufficIcon: const Text('g'),
                  controller: gramController,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
