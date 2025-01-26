import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/calendar_controller.dart';
import 'package:every_pet/view/calendar/calendar_screen.dart';
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
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: controller.clickAddbtn,
              child: Text(
                  controller.isNotEmptyFocusedDayEvent() ? '予定を変更' : '予定を追加'),
            ),
          ),
          if (controller.isNotEmptyFocusedDayEvent())
            Column(
              children: [
                Text(controller.getFocusedDayEvent()![0].memo),
                Wrap(
                  children: List.generate(
                    controller.getFocusedDayEvent()![0].stamps.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: Responsive.height10,
                        left: Responsive.width10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: AppColors.blueLight.withOpacity(.5),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              controller
                                  .getFocusedDayEvent()![0]
                                  .stamps[index]
                                  .icon,
                            ),
                          ),
                          SizedBox(width: Responsive.width10),
                          Text(
                            controller
                                .getFocusedDayEvent()![0]
                                .stamps[index]
                                .name,
                          ),
                        ],
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
  List<int> selectedIndexs = [];
  TextEditingController memoController = TextEditingController(text: 'これはメモです');

  @override
  void dispose() {
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('メモ'),
              CustomTextField(
                maxLines: 2,
                controller: memoController,
              ),
            ],
          ),
          SizedBox(height: Responsive.height10),
          Wrap(
            children: List.generate(
              controller.stamps.length,
              (index) => ColIconButton(
                icon: controller.stamps[index].icon,
                label: controller.stamps[index].name,
                onTap: () {
                  if (selectedIndexs.contains(index)) {
                    selectedIndexs.remove(index);
                  } else {
                    selectedIndexs.add(index);
                  }
                  setState(() {});
                },
                isActive: selectedIndexs.contains(index),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () {}, child: Text('カスタマイズ')),
          ),
          SizedBox(height: Responsive.height20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Get.back(result: null),
                child: const Text('取消'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back(result: {
                      'selectedIndexs': selectedIndexs,
                      'memo': memoController.text,
                    });
                  },
                  child: const Text('保存')),
            ],
          ),
        ],
      );
    });
  }
}
