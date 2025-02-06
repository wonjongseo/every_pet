import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GendarSelector extends StatelessWidget {
  const GendarSelector(
      {super.key, required this.genderType, required this.onChangeGender});
  final GENDER_TYPE genderType;
  final Function(GENDER_TYPE?) onChangeGender;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppString.genderText.tr,
          style: TextStyle(
            fontSize: Responsive.width16,
            fontWeight: FontWeight.w500,
          ),
        ),
        DropdownButton(
          elevation: 0,
          value: genderType,
          underline: const SizedBox(),
          items: [
            if (genderType == GENDER_TYPE.MALE) ...[
              DropdownMenuItem(
                value: GENDER_TYPE.MALE,
                child: Image.asset(
                  AppImagePath.circleMale,
                  width: Responsive.width10 * 3,
                  height: Responsive.width10 * 3,
                ),
              ),
              DropdownMenuItem(
                value: GENDER_TYPE.FEMALE,
                child: Image.asset(
                  AppImagePath.circleFemale,
                  width: Responsive.width10 * 3,
                  height: Responsive.width10 * 3,
                ),
              )
            ] else ...[
              DropdownMenuItem(
                value: GENDER_TYPE.FEMALE,
                child: Image.asset(
                  AppImagePath.circleFemale,
                  width: Responsive.width10 * 3,
                  height: Responsive.width10 * 3,
                ),
              ),
              DropdownMenuItem(
                value: GENDER_TYPE.MALE,
                child: Image.asset(
                  AppImagePath.circleMale,
                  width: Responsive.width10 * 3,
                  height: Responsive.width10 * 3,
                ),
              ),
            ]
          ],
          // onChanged: (v) => controller.onChangeGendar(v),
          onChanged: (v) => onChangeGender(v),
        )
      ],
    );
  }
}
