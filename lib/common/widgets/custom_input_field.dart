import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.title,
    required this.hint,
    this.prefixText,
    this.controller,
    this.widget,
    this.selectedStamps,
  });

  final String title;
  final String? prefixText;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  final List<int>? selectedStamps;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: activeHintStyle,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    readOnly: widget == null ? false : true,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      prefix: Text(prefixText ?? ''),
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget != null) widget!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}




//

