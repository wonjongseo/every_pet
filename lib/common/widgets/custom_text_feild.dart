import 'package:every_pet/common/extension/custom_theme_extension.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.keyboardType,
    this.prefixText,
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
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      focusNode: focusNode,
      maxLines: maxLines,
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: readOnly == null ? keyboardType : null,
      onChanged: onChanged,
      maxLength: maxLength,
      style: TextStyle(fontSize: fontSize, fontFamily: "ZenMaruGothic"),
      autofocus: autoFocus ?? false,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        isDense: true,
        prefixText: prefixText,
        suffix: sufficIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: context.exTheme.greyColor),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.greenDark,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.greenDark,
            width: 2,
          ),
        ),
      ),
    );
  }
}
