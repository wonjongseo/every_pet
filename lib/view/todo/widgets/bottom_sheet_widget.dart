import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/common/widgets/short_bar.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/view/todo/todo_screen.dart';
import 'package:every_pet/view/todo/widgets/row_stamp_widget.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .6,
        minHeight: 200,
      ),
      child: GetBuilder<TodoController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShortHBar(width: Responsive.width10 * 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppFunction.getDayYYYYMMDD(controller.focusedDay),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.width18,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.clickAddbtn,
                      child: Text(
                        controller.isNotEmptyFocusedDayEvent()
                            ? AppString.updateExampleBtnTr.tr
                            : AppString.addScheduleText.tr,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.height10),
              if (controller.isNotEmptyFocusedDayEvent())
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: Responsive.width20,
                        left: Responsive.width20,
                        bottom: Responsive.height20,
                      ),
                      child: CustomTextField(
                        readOnly: true,
                        maxLines: 2,
                        hintText: controller.getFocusedDayEvent()![0].memo,
                      ),
                    ),
                    Column(
                      children: List.generate(
                        controller.getFocusedDayEvent()![0].stamps.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                            bottom: Responsive.height10,
                            left: Responsive.width10,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.width10 * 2,
                            ),
                            child: RowStampWidget(
                                stamp: controller
                                    .getFocusedDayEvent()![0]
                                    .stamps[index]),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  AppString.notTextScheduleText.tr,
                  style: TextStyle(fontSize: Responsive.width18),
                ),
              SizedBox(height: Responsive.height30),
            ],
          ),
        );
      }),
    );
  }
}
