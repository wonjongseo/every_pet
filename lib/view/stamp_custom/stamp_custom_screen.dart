import 'package:every_pet/background2.dart';
import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/view/stamp_custom/widgets/enroll_stamp_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StampCustomScreen extends StatelessWidget {
  const StampCustomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.editStampText.tr, style: headingStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AddOrRemoveButton(
              onTap: () async {
                Get.dialog(
                  name: 'EnrollStampDialog',
                  AlertDialog(
                    insetPadding:
                        EdgeInsets.symmetric(horizontal: Responsive.width15),
                    content: const EnrollStampDialog(),
                  ),
                );
              },
              addOrRemove: AddOrRemoveType.ADD,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: BackGround2(
        widget: GetBuilder<StampController>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.only(
              top: Responsive.width20,
              bottom: Responsive.width20,
              left: Responsive.width20,
              right: Responsive.width10,
            ),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    iconColor: AppColors.primaryColor,
                    leading: Container(
                      height: Responsive.width10 * 5,
                      width: Responsive.width10 * 5,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.5),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        StampModel.getIcon(controller.stamps[index].iconIndex),
                      ),
                    ),
                    title: CustomTextField(
                      hintText: controller.stamps[index].name,
                      hintStyle: activeHintStyle,
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            content: EnrollStampDialog(
                              stamp: controller.stamps[index],
                            ),
                          ),
                        );
                      },
                      readOnly: true,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: controller.stamps[index].isVisible,
                          onChanged: (v) => controller.toggleVisable(index),
                        ),
                        AddOrRemoveButton(
                          onTap: () =>
                              controller.deleteStamp(controller.stamps[index]),
                          addOrRemove: AddOrRemoveType.REMOVE,
                          width: Responsive.width10 * 4,
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(thickness: .5);
                },
                itemCount: controller.stamps.length),
          );
        }),
      ),
    );
  }
}
