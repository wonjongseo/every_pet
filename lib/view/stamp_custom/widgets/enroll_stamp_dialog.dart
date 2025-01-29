import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
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

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<int>(
                isExpanded: true,
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
                value: stampIconIndexValue,
                onChanged: (int? value) {
                  setState(() {
                    stampIconIndexValue = value!;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  padding:
                      EdgeInsets.symmetric(horizontal: Responsive.height16),
                  width: Responsive.width10 * 10,
                ),
              ),
            ),

            // DropdownButton(
            //   value: stampIconIndexValue,
            //   items: List.generate(
            //     CUSTOM_STAMP_ICON_NUM,
            //     (index) {
            //       return DropdownMenuItem(
            //         value: index,
            //         child: SizedBox(
            //           width: Responsive.width10 * 4,
            //           height: Responsive.width10 * 4,
            //           child: Image.asset(
            //             StampModel.getIcon(index),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            //   onChanged: (v) {
            //     if (v == null) return;
            //     stampIconIndexValue = v;
            //     setState(() {});
            //   },
            // ),
            SizedBox(width: Responsive.width20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.4,
              child: Form(
                key: _formKey,
                child: CustomTextField(
                  validator: (p0) {
                    if (p0 == null || p0 == "") {
                      return AppString.stampNameCtlMsg.tr;
                    }
                    return null;
                  },
                  controller: textEditingController,
                  hintText: AppString.stampNameCtlHintTr.tr,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: Responsive.height20),
        OkOrNoBtnRow(
          okText: widget.stamp != null
              ? AppString.updateBtnTextTr.tr
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
    StampModel stampModel = StampModel(
        name: textEditingController.text,
        iconIndex: stampIconIndexValue,
        isVisible: true,
        isCustom: true);
    stampController.saveStamp(stampModel);
    Get.back();
  }

  void updateStamp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.stamp!.name = textEditingController.text;
    widget.stamp!.iconIndex = stampIconIndexValue;

    stampController.updateStamp(widget.stamp!);
    Get.back();
  }
}
