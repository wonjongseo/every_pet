import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/view/nutrition/nutrition_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodScreenNavigation extends StatelessWidget {
  const FoodScreenNavigation(
      {super.key, required this.foodType, required this.onChanged});

  final NUTRITION_TYPE foodType;
  final Function(NUTRITION_TYPE?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
            title: Text(AppString.dryTextTr.tr),
            value: NUTRITION_TYPE.DRY,
            groupValue: foodType,
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: Text(AppString.handmadeTextTr.tr),
            value: NUTRITION_TYPE.MANUL,
            groupValue: foodType,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
