import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/view/calculate_kcal/edit_groceries_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CalculateKcalScreen extends StatelessWidget {
  const CalculateKcalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CalculateKcalController());

    return GetBuilder<CalculateKcalController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            '${controller.pet.name}의 식단',
            style: headingStyle,
          ),
          actions: [
            IconButton(
                onPressed: () => Get.to(() => const EditGroceriesScreen()),
                icon: const FaIcon(
                  FontAwesomeIcons.pencil,
                  color: AppColors.primaryColor,
                ))
          ],
        ),
        bottomNavigationBar: const GlobalBannerAdmob(),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      notionDer(controller),
                      const Text.rich(
                        TextSpan(
                            text:
                                'Every app에서 제공하는 식재료 칼로리를 이용해\n한 끼 칼로리를 측정해요.',
                            style: TextStyle(
                              letterSpacing: 1.2,
                            )),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Responsive.height30),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _givenCountPerDayDropDownBtn(context, controller),
                              TextButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        surfaceTintColor: Colors.white,
                                        contentPadding: EdgeInsets.all(8),
                                        content: _allGroceries(context),
                                      ),
                                    );
                                  },
                                  child: Text('식단 추가'))
                            ],
                          ),
                          _selectedGroceries(controller),
                        ],
                      ),
                    ],
                  ),
                )),
                Divider(
                  height: Responsive.height40,
                  thickness: 2,
                ),
                // _allGroceries(controller)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _allGroceries(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<CalculateKcalController>(builder: (controller) {
      return SizedBox(
        height: size.height * .6,
        width: size.width * 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Responsive.height10,
                  horizontal: Responsive.width20),
              child: Text(
                '매뉴를 선택해주세요.',
                style: headingStyle.copyWith(color: AppColors.primaryColor),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  bool isSelected = controller.selectedGroceriesModels
                      .contains(controller.groceriesModels[index]);
                  return ListTile(
                    dense: true,
                    iconColor:
                        isSelected ? Colors.grey[400] : AppColors.primaryColor,
                    leading: Text(
                      controller.groceriesModels[index].name,
                      style: activeHintStyle,
                    ),
                    minLeadingWidth: Responsive.width10 * 6,
                    title:
                        Text('${controller.groceriesModels[index].kcal}Kcal'),
                    subtitle: Text(
                      '(${controller.groceriesModels[index].gram}Gram)',
                    ),
                    trailing: IconButton(
                      onPressed: () => isSelected
                          ? null
                          : controller
                              .onAddBtnClick(controller.groceriesModels[index]),
                      icon: const Icon(Icons.add),
                    ),
                    onTap: () => isSelected
                        ? null
                        : controller
                            .onAddBtnClick(controller.groceriesModels[index]),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(thickness: .5);
                },
                itemCount: controller.groceriesModels.length,
              ),
            ),
          ],
        ),
      );
    });
  }

  Column _selectedGroceries(CalculateKcalController controller) {
    return Column(
      children: List.generate(
        controller.displayGroceries.length,
        (index) => ListTile(
          iconColor: AppColors.primaryColor,
          leading: Text(
            controller.displayGroceries[index].name ?? '',
            style: activeHintStyle,
          ),
          minLeadingWidth: Responsive.width10 * 6,
          title: Text.rich(
            TextSpan(
                text: '${controller.displayGroceries[index].gram}Gram',
                style: activeHintStyle,
                children: [
                  TextSpan(
                      text: '(${controller.displayGroceries[index].kcal}Kcal)',
                      style: subTitleStyle)
                ]),
          ),
          trailing: IconButton(
            onPressed: () => controller.onRemoteBtnClick(index),
            icon: Icon(Icons.remove),
          ),
        ),
      ),
    );
  }

  Align _givenCountPerDayDropDownBtn(
      BuildContext context, CalculateKcalController controller) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        margin: EdgeInsets.only(left: Responsive.width10),
        child: CustomTextField(
          readOnly: true,
          hintText: '${controller.givenCountPerDay}회 / 1일당',
          hintStyle: activeHintStyle,
          widget: DropdownButton(
            iconSize: 32,
            underline: SizedBox(),
            items: [
              DropdownMenuItem(value: 1, child: Text('1회')),
              DropdownMenuItem(value: 2, child: Text('2회')),
              DropdownMenuItem(value: 3, child: Text('3회')),
            ],
            onChanged: controller.changeCountPerDay,
          ),
        ),
      ),
    );
  }

  Text notionDer(CalculateKcalController controller) {
    return Text.rich(
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
            text: controller.pet.genderType == GENDER_TYPE.MALE
                ? AppString.sufficMaleText.tr
                : AppString.sufficFeMaleTextTr.tr,
            children: [
              TextSpan(text: AppString.ofText.tr),
              TextSpan(
                text: AppString.tekiryouKcalText.tr,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: Responsive.width18,
                ),
              ),
              TextSpan(text: AppString.isText.tr),
              TextSpan(
                text: '${controller.pet.getDER().toString()}kcal',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: Responsive.width20,
                ),
              ),
              TextSpan(text: AppString.desuText.tr),
            ],
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: Responsive.width15,
            ),
          ),
        ],
      ),
    );
  }
}
