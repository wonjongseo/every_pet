import 'package:every_pet/common/utilities/app_color.dart';
import 'package:flutter/material.dart';

class OkOrNoBtnRow extends StatelessWidget {
  const OkOrNoBtnRow({
    Key? key,
    required this.okText,
    required this.onOkTap,
    required this.noText,
    required this.onNotap,
  }) : super(key: key);

  final String okText;
  final String noText;
  final Function() onOkTap;
  final Function() onNotap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
          ),
          onPressed: onOkTap,
          child: Text(okText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black),
          onPressed: onNotap,
          child: Text(noText),
        ),
      ],
    );
  }
}
