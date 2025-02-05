import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddMenuDialog extends StatelessWidget {
  const AddMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                AppString.addMenuMsg.tr,
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
                    minLeadingWidth: MediaQuery.of(context).size.width / 4.5,
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
}
