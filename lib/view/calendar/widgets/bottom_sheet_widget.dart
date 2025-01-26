import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/common/widgets/short_bar.dart';
import 'package:every_pet/controllers/calendar_controller.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/view/calendar/calendar_screen.dart';
import 'package:every_pet/view/calendar/widgets/row_stamp_widget.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShortHBar(
            width: Responsive.width10 * 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  UtilFunction.getDayYYYYMMDD(controller.focusedDay),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.width18,
                  ),
                ),
                TextButton(
                  onPressed: controller.clickAddbtn,
                  child: Text(
                    controller.isNotEmptyFocusedDayEvent() ? '予定を変更' : '予定を追加',
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
            const Text(
              'まだ予定がありません。',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          SizedBox(height: Responsive.height30),
        ],
      );
    });
  }
}

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  List<StampModel> selectedStamps = [];
  TextEditingController memoController = TextEditingController();
  CalendarController controller = Get.find<CalendarController>();

  @override
  void initState() {
    selectedStamps = controller.getSavedStampIndex();

    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    memoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('メモ'),
            CustomTextField(
              maxLines: 2,
              controller: memoController,
              hintText: 'Todo..',
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: controller.stampController.goToStampCustomScreen,
            child: Text('スタンプ編集'),
          ),
        ),
        GetBuilder<StampController>(builder: (stampController) {
          return Wrap(
            runSpacing: Responsive.height14,
            children: List.generate(
              stampController.stamps
                  .where((element) => element.isVisible)
                  .length,
              // controller.stampController.stamps
              //     .where((element) => element.isVisible)
              //     .length,
              (index) {
                // StampModel stampModel = controller.stampController.stamps[index];
                StampModel stampModel = stampController.stamps[index];
                return ColIconButton(
                  icon: stampModel.getIcon(),
                  label: stampModel.name,
                  onTap: () {
                    if (selectedStamps.contains(stampModel)) {
                      selectedStamps.remove(stampModel);
                    } else {
                      selectedStamps.add(stampModel);
                    }
                    setState(() {});
                  },
                  isActive: selectedStamps.contains(
                    // controller.stampController.stamps[index],
                    stampController.stamps[index],
                  ),
                );
              },
            ),
          );
        }),
        SizedBox(height: Responsive.height40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back(result: {
                  'selectedStamps': selectedStamps,
                  'memo': memoController.text,
                });
              },
              child: const Text('保存'),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: null),
              child: const Text('取消'),
            ),
          ],
        ),
      ],
    );
  }
}
