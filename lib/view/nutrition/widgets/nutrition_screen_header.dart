import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionScreenHeader extends StatelessWidget {
  const NutritionScreenHeader({
    super.key,
    required this.pet,
  });

  final PetModel pet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.width15, vertical: Responsive.height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Expanded(
          //   flex: 2,
          //   child: ProfileImage(
          //     isDog: pet.runtimeType == DogModel,
          //     height: Responsive.width10 * 11,
          //     width: Responsive.width10 * 11,
          //     imagePath: pet.imageUrl,
          //   ),
          // ),
          // SizedBox(width: Responsive.width20),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: pet.name,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Responsive.width20,
                          ),
                        ),
                        TextSpan(
                          text: pet.genderType == GENDER_TYPE.MALE
                              ? AppString.sufficMaleText.tr
                              : AppString.sufficFeMaleTextTr.tr,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Responsive.width15,
                          ),
                        ),
                        TextSpan(
                          text: '  (',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Responsive.width15,
                          ),
                        ),
                        TextSpan(
                          children: [
                            TextSpan(
                              text: pet.getAgeYear().toString(),
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.width20,
                              ),
                            ),
                            TextSpan(
                              text: AppString.ageYearTextTr.tr,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.width15,
                              ),
                            ),
                            TextSpan(text: '  '),
                            TextSpan(
                              text: pet.getAgeMonth().toString(),
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.width20,
                              ),
                            ),
                            TextSpan(
                              text: AppString.ageMonthText.tr,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.width15,
                              ),
                            ),
                            TextSpan(
                              text: ')',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: Responsive.width15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Responsive.width10 * 12,
                            child: Text(
                              AppString.derTextTr.tr,
                              style: TextStyle(
                                fontSize: Responsive.width14,
                              ),
                            ),
                          ),
                          Text('${pet.getRER()}kcal'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Responsive.width10 * 12,
                            child: Text(
                              AppString.tekiryouKcalText.tr,
                              style: TextStyle(
                                fontSize: Responsive.width14,
                              ),
                            ),
                          ),
                          Text('${pet.getDER()}kcal'),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
