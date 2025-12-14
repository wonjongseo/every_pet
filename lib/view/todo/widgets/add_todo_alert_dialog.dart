import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/widgets/ok_or_no_row_btn.dart';
import 'package:every_pet/features/todos/controller/edit_detail_todo_controller.dart';
import 'package:every_pet/features/todos/screen/add_detail_todo_screen.dart';
import 'package:every_pet/features/todos/screen/widgets/add_todo_pet_selector.dart';
import 'package:every_pet/features/todos/screen/widgets/edit_stamp_selector.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';

//
class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({super.key, this.todo});

  final TodoModel? todo;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditDetailTodoController(todo));
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AddTodoPetSelector(),
        Divider(height: Responsive.height10),
        SizedBox(height: Responsive.height10),
        CustomTextField(
          maxLines: 2,
          controller: controller.memoController,
          hintText: 'Memo',
        ),
        _textIconButton(
          onPressed: () {
            Get.back(); // 1.2.0+4 StampCustomScreen 이동 후 스탬프 변경하고, 다시 StampCustomScreen으로 이동하려면 버튼 작용 안하는 버그해결
            Get.toNamed(StampCustomScreen.name);
          },
          label: AppString.editStampText.tr,
        ),
        // SizedBox(height: Responsive.height10 / 2),
        SizedBox(
          height: (Responsive.width10 * 5) * 5.5,
          width: size.width * .8,
          child: const EditStampSelector(),
        ),
        _textIconButton(
          label: '상세',
          onPressed: () {
            Get.toNamed(EditDetailTodoScreen.name);
          },
        ),
        OkOrNoBtnRow(
          okText: AppString.saveText.tr,
          noText: AppString.cancelBtnTextTr.tr,
          onOkTap: () {
            Get.back(result: {
              'selectedStamps': controller.selectedStamps,
              'memo': controller.memoController.text,
              'selectedProfileIndexs': controller.selectedProfileIndexs
            });
          },
          onNotap: () => Get.back(result: null),
        ),
      ],
    );
  }

  Align _textIconButton({
    required Function() onPressed,
    required String label,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            SizedBox(width: Responsive.width10 / 2),
            const FaIcon(FontAwesomeIcons.caretRight),
          ],
        ),
      ),
    );
  }
}

class StampListWidget extends StatelessWidget {
  const StampListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
