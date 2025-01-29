import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/widgets/ok_or_no_row_btn.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:every_pet/view/todo/todo_screen.dart';

class EnrollTodoDialog extends StatefulWidget {
  const EnrollTodoDialog({super.key, this.memo});

  final String? memo; //
  @override
  State<EnrollTodoDialog> createState() => _EnrollTodoDialogState();
}

class _EnrollTodoDialogState extends State<EnrollTodoDialog> {
  List<StampModel> selectedStamps = [];
  TextEditingController memoController = TextEditingController();
  TodoController controller = Get.find<TodoController>();
  List<int> selectedProfileIndexs = [];
  @override
  void initState() {
    memoController.text = widget.memo ?? '';
    selectedStamps = controller.getSavedStampIndex();
    selectedProfileIndexs.add(controller.petsController.petPageIndex);

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
        SizedBox(height: Responsive.height10),
        Row(
          children: List.generate(
            controller.petsController.pets!.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(right: Responsive.width22),
                child: RowPetProfileWidget(
                  isDog: controller.petsController.pets![index].runtimeType ==
                      DogModel,
                  imagePath: controller.petsController.pets![index].imageUrl,
                  petName: controller.petsController.pets![index].name,
                  isActive: selectedProfileIndexs.contains(index),
                  onTap: () {
                    if (selectedProfileIndexs.contains(index)) {
                      selectedProfileIndexs.remove(index);
                    } else {
                      selectedProfileIndexs.add(index);
                    }
                    setState(() {});
                    print(index);
                    // controller.petsController.onClickTopBar(index);
                  },
                ),
              );
            },
          ),
        ),
        Divider(height: Responsive.height20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppString.changeStampTextTr.tr),
                  SizedBox(width: Responsive.width10 / 2),
                  const FaIcon(FontAwesomeIcons.caretRight),
                ],
              )),
        ),
        GetBuilder<StampController>(builder: (stampController) {
          return Wrap(
            runSpacing: Responsive.height14,
            children: List.generate(
              stampController.stamps
                  .where((element) => element.isVisible)
                  .length,
              (index) {
                StampModel stampModel = stampController.stamps[index];
                return ColIconButton(
                  icon: StampModel.getIcon(stampModel.iconIndex),
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
        OkOrNoBtnRow(
          okText: AppString.saveTextTr.tr,
          noText: AppString.cancelBtnTextTr.tr,
          onOkTap: () {
            Get.back(result: {
              'selectedStamps': selectedStamps,
              'memo': memoController.text,
              'selectedProfileIndexs': selectedProfileIndexs
            });
          },
          onNotap: () => Get.back(result: null),
        ),
      ],
    );
  }
}
