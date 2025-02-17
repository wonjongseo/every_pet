import 'dart:math' as math;
import 'package:every_pet/background2.dart';
import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/view/full_profile_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/controllers/pets_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(builder: (petsController) {
      return GestureDetector(
        onTap: petsController.closeBottomSheet,
        child: Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const GlobalBannerAdmob(),
              bottomNavigtionBar(petsController),
            ],
          ),
          body: BackGround2(
            widget: SafeArea(
              child: Column(
                children: [
                  topNavigationBar(petsController),
                  const Divider(),
                  Expanded(
                    child: petsController.body[petsController.bottomTapIndex],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Padding topNavigationBar(PetsController petsController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width10 * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  petsController.petsLength,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: Responsive.width22),
                      child: RowPetProfileWidget(
                        genderType:
                            petsController.getPetOfIndex(index)!.genderType,
                        petName: petsController.getPetOfIndex(index)!.name,
                        isActive: petsController.petPageIndex == index,
                        imagePath:
                            petsController.getPetOfIndex(index)!.profilePath,
                        onTap: () {
                          petsController.onTapTopBar(index);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          AddOrRemoveButton(
            onTap: petsController.goToEnrollScreen,
            addOrRemove: AddOrRemoveType.ADD,
          ),
        ],
      ),
    );
  }

  Widget bottomNavigtionBar(PetsController petsController) {
    return BottomNavigationBar(
      currentIndex: petsController.bottomTapIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      onTap: petsController.onTapBottomBar,
      selectedLabelStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w500),
      selectedItemColor: AppColors.primaryColor,
      items: [
        BottomNavigationBarItem(
          label: AppString.calendarTextTr.tr,
          icon: Column(
            children: [
              Image.asset(
                AppImagePath.circleCalendar,
                width: Responsive.width10 * 5,
              ),
            ],
          ),
        ),
        BottomNavigationBarItem(
          label: AppString.foodTextTr.tr,
          icon: Image.asset(
            AppImagePath.circleFood,
            width: Responsive.width10 * 5,
          ),
        ),
        BottomNavigationBarItem(
          label: AppString.expensiveTextTr.tr,
          icon: Image.asset(
            AppImagePath.circleWallet,
            width: Responsive.width10 * 5,
          ),
        ),
        BottomNavigationBarItem(
          label: AppString.settingTr.tr,
          icon: Image.asset(
            AppImagePath.circleSetting,
            width: Responsive.width10 * 5,
          ),
        ),
      ],
    );
  }
}

class RowPetProfileWidget extends StatelessWidget {
  const RowPetProfileWidget({
    Key? key,
    required this.isActive,
    required this.petName,
    required this.onTap,
    required this.genderType,
    required this.imagePath,
  }) : super(key: key);

  final bool isActive;
  final String petName;
  final GENDER_TYPE genderType;
  final VoidCallback onTap;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(
          onTap: onTap,
          onLongPress: () => Get.to(
            () => FullProfileImageScreen(imagePath: imagePath),
          ),
          imagePath: imagePath,
          width: Responsive.width10 * 4.5,
          height: Responsive.width10 * 4.5,
          isActive: isActive,
          genderType: genderType,
        ),
        Text(
          petName,
          style: isActive
              ? TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: Responsive.width14,
                )
              : TextStyle(color: Colors.grey.withOpacity(.7)),
        ),
      ],
    );
  }
}
