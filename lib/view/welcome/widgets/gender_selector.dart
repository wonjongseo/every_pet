import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/welcome_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GendarSelector extends StatelessWidget {
  const GendarSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnrollController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppString.genderTextJp.tr,
            style: TextStyle(
              fontSize: Responsive.width16,
              fontWeight: FontWeight.w500,
            ),
          ),
          DropdownButton(
            elevation: 0,
            value: controller.genderType,
            underline: null,
            items: [
              if (controller.genderType == GENDER_TYPE.MALE) ...[
                DropdownMenuItem(
                  value: GENDER_TYPE.MALE,
                  child: Text(
                    GENDER_TYPE.MALE.gender,
                    style: TextStyle(
                      fontSize: Responsive.width18,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: GENDER_TYPE.FEMALE,
                  child: Text(
                    GENDER_TYPE.FEMALE.gender,
                    style: TextStyle(
                      fontSize: Responsive.width18,
                    ),
                  ),
                )
              ] else ...[
                DropdownMenuItem(
                  value: GENDER_TYPE.FEMALE,
                  child: Text(
                    GENDER_TYPE.FEMALE.gender,
                    style: TextStyle(
                      fontSize: Responsive.width18,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: GENDER_TYPE.MALE,
                  child: Text(
                    GENDER_TYPE.MALE.gender,
                    style: TextStyle(
                      fontSize: Responsive.width18,
                    ),
                  ),
                ),
              ]
            ],
            onChanged: (v) => controller.onChangeGendar(v),
          )
        ],
      );
    });
  }
}
