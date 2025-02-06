import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/view/calculate_kcal/edit_groceries_screen.dart';
import 'package:every_pet/view/calculate_kcal/widgets/add_menu_dialog.dart';
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
        appBar: appBar(controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: Responsive.height10),
                notionDer(controller),
                Text.rich(
                  TextSpan(
                    text: AppString.calculateKcalScreenSubText.tr,
                    style: const TextStyle(
                      letterSpacing: 1.2,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Responsive.height30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _givenCountPerDayDropDownBtn(context, controller),
                            TextButton(
                              onPressed: () {
                                Get.dialog(
                                  name: "AddMenuDialog",
                                  const AlertDialog(
                                    surfaceTintColor: Colors.white,
                                    contentPadding: EdgeInsets.all(8),
                                    content: AddMenuDialog(),
                                  ),
                                );
                              },
                              child: Text(AppString.addmMenuText.tr),
                            )
                          ],
                        ),
                        SizedBox(height: Responsive.height10),
                        _selectedGroceries(controller, context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  AppBar appBar(CalculateKcalController controller) {
    return AppBar(
      title: Text(
        '${controller.pet.name}${AppString.calculateKcalScreenHeader}',
        style: headingStyle,
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(() => const EditGroceriesScreen()),
          icon: const FaIcon(
            FontAwesomeIcons.pencil,
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }

  Widget _selectedGroceries(
    CalculateKcalController controller,
    BuildContext context,
  ) {
    return Column(
      children: List.generate(
        controller.displayGroceries.length,
        (index) {
          return ListTile(
            iconColor: AppColors.primaryColor,
            leading: Text(
              controller.displayGroceries[index].name ?? '',
              style: contentStyle,
            ),
            minLeadingWidth: MediaQuery.of(context).size.width / 4,
            title: Text.rich(
              TextSpan(
                  text: '${controller.displayGroceries[index].gram}Gram',
                  style: contentStyle,
                  children: [
                    TextSpan(
                        text:
                            '(${controller.displayGroceries[index].kcal}Kcal)',
                        style: contentStyle)
                  ]),
            ),
            trailing: IconButton(
              onPressed: () => controller.onRemoteBtnClick(index),
              icon: Icon(Icons.remove),
            ),
          );
        },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              readOnly: true,
              hintText: AppFunction.isEn()
                  ? '${controller.givenCountPerDay}${AppString.countText.tr}'
                  : '${controller.givenCountPerDay}${AppString.countText.tr} / ${AppString.perOneDayText.tr}',
              hintStyle: contentStyle,
              widget: DropdownButton(
                iconSize: 32,
                underline: const SizedBox(),
                items: [
                  DropdownMenuItem(
                      value: 1, child: Text('1${AppString.countText.tr}')),
                  DropdownMenuItem(
                      value: 2, child: Text('2${AppString.countText.tr}')),
                  DropdownMenuItem(
                      value: 3, child: Text('3${AppString.countText.tr}')),
                ],
                onChanged: controller.changeCountPerDay,
              ),
            ),
            if (AppFunction.isEn())
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '(${AppString.perOneDayText.tr})',
                  style: subTitleStyle.copyWith(
                    fontSize: Responsive.width10 * 1.3,
                  ),
                ),
              )
            else
              SizedBox(height: Responsive.height10),
          ],
        ),
      ),
    );
  }

  Text notionDer(CalculateKcalController controller) {
    return Text.rich(
      textAlign: TextAlign.center,
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
                text: AppString.derTextText.tr,
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
