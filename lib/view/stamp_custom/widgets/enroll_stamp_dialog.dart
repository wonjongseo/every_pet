import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/common/widgets/ok_or_no_row_btn.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnrollStampDialog extends StatefulWidget {
  const EnrollStampDialog({super.key, this.stamp});

  final StampModel? stamp; // if it is not null , stamp  will be updated
  @override
  State<EnrollStampDialog> createState() => _EnrollStampDialogState();
}

class _EnrollStampDialogState extends State<EnrollStampDialog> {
  late int stampIconIndexValue;
  late TextEditingController textEditingController;
  StampController stampController = Get.find<StampController>();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    stampIconIndexValue = widget.stamp?.iconIndex ?? 0;
    textEditingController =
        TextEditingController(text: widget.stamp?.name ?? '');
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            DropdownButton(
              underline: Container(),
              value: stampIconIndexValue,
              iconSize: 32,
              elevation: 4,
              padding: EdgeInsets.zero,
              items: List.generate(
                AppConstant.countOfStampIcon,
                (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: SizedBox(
                      width: Responsive.width10 * 5,
                      height: Responsive.width10 * 5,
                      child: Image.asset(
                        StampModel.getIcon(index),
                      ),
                    ),
                  );
                },
              ),
              onChanged: (v) {
                if (v == null) return;
                stampIconIndexValue = v;
                setState(() {});
              },
            ),
            SizedBox(width: Responsive.width20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.4,
              child: Form(
                key: _formKey,
                child: CustomTextField(
                  autoFocus: true,
                  controller: textEditingController,
                  hintText: AppString.stampName,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: Responsive.height20),
        OkOrNoBtnRow(
          okText: widget.stamp != null
              ? AppString.updateBtnText.tr
              : AppString.enrollTextBtnTr.tr,
          noText: AppString.cancelBtnTextTr.tr,
          onOkTap: () {
            if (widget.stamp != null) {
              updateStamp();
            } else {
              createStamp();
            }
          },
          onNotap: () => Get.back(),
        )
      ],
    );
  }

  void createStamp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (textEditingController.text.isEmpty) {
      AppFunction.showInvalidTextFieldSnackBar(
          message: AppString.stampNameCtlMsg.tr);
      return;
    }

    StampModel stampModel = StampModel(
      name: textEditingController.text,
      iconIndex: stampIconIndexValue,
      isVisible: true,
    );

    stampController.saveStamp(stampModel);
    Get.back();

    AppFunction.showSuccessEnrollMsgSnackBar(stampModel.name);
  }

  void updateStamp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // 1.2.0+4 스탬프 변경 하면 show snack Bar
    if (widget.stamp == null) return;
    if (textEditingController.text.isEmpty) {
      AppFunction.showInvalidTextFieldSnackBar(
          message: AppString.stampNameCtlMsg.tr);
      return;
    }
    if (widget.stamp!.name == textEditingController.text) {
      Get.back();
      return;
    }
    // 1.2.0+4 스탬프 변경 하면 show snack Bar

    StampModel updatedStamp = widget.stamp!.copyWith(
        name: textEditingController.text, iconIndex: stampIconIndexValue);

    stampController.updateStamp(updatedStamp);
    // 1.2.0+4 스탬프 변경 하면 show snack Bar
    Get.back();
    AppFunction.showSuccessChangedMsgSnackBar(updatedStamp.name);
    // 1.2.0+4 스탬프 변경 하면 show snack Bar
  }
}
