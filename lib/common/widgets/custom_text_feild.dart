import 'package:every_pet/common/extension/custom_theme_extension.dart';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.keyboardType,
    this.prefixIcon,
    this.onTap,
    this.sufficIcon,
    this.onChanged,
    this.fontSize,
    this.maxLines,
    this.autoFocus,
    this.maxLength,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.hintStyle,
    this.style,
    this.widget,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final Widget? sufficIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? widget;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              inputFormatters: inputFormatters,
              textInputAction: textInputAction,
              focusNode: focusNode,
              maxLines: maxLines ?? 1,
              onTap: onTap,
              controller: controller,
              readOnly: readOnly ?? false,
              textAlign: textAlign ?? TextAlign.start,
              keyboardType: keyboardType,
              onChanged: onChanged,
              maxLength: maxLength,
              onFieldSubmitted: onFieldSubmitted,
              autofocus: autoFocus ?? false,
              validator: validator,
              style: style ?? subTitleStyle,
              cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
              decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(minHeight: 0, minWidth: 0),
                suffixIconConstraints:
                    const BoxConstraints(minHeight: 0, minWidth: 0),
                contentPadding: EdgeInsets.symmetric(
                  vertical: Responsive.height11,
                  horizontal: Responsive.width10,
                ),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(right: Responsive.width10),
                        child: prefixIcon,
                      )
                    : null,
                isDense: true,
                suffixIcon: sufficIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(right: Responsive.width10),
                        child: sufficIcon,
                      )
                    : null,
                hintText: hintText,
                hintStyle: hintStyle ??
                    TextStyle(
                      fontSize: Responsive.width14,
                      fontWeight: FontWeight.w400,
                      color:
                          Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                    ),
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
          if (widget != null) widget!
        ],
      ),
    );
  }
}
