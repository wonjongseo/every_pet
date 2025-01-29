import 'dart:io';

import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/models/dog_model.dart';
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

  // int navigationPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(builder: (petsController) {
      return GestureDetector(
        onTap: petsController.closeBottomSheet,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const GlobalBannerAdmob(),
              bottomNavigtionBar(petsController),
            ],
          ),
          body: SafeArea(
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
      );
    });
  }

  Padding topNavigationBar(PetsController petsController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  petsController.pets!.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: Responsive.width22),
                      child: RowPetProfileWidget(
                        isDog:
                            petsController.pets![index].runtimeType == DogModel,
                        petName: petsController.pets![index].name,
                        isActive: petsController.petPageIndex == index,
                        imagePath: petsController.pets![index].imageUrl,
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
          InkWell(
            onTap: petsController.goToEnrollScreen,
            // style: IconButton.styleFrom(
            //     backgroundColor: AppColors.primaryColor,
            //     foregroundColor: AppColors.backgroundLight),
            // icon: const Icon(Icons.add),
            child: Image.asset(
              AppImagePath.circleAddBtn,
              width: Responsive.width10 * 5,
            ),
          )
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
      // unselectedLabelStyle: TextStyle(color: Colors.transparent),
      selectedLabelStyle: const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w500),
      selectedItemColor: AppColors.primaryColor,
      // selectedIconTheme: IconThemeData(color: Colors.transparent),
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
    required this.imagePath,
    required this.isDog,
  }) : super(key: key);

  final bool isActive;
  final String petName;
  final VoidCallback onTap;
  final String imagePath;
  final bool isDog;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ProfileImage(
            isDog: isDog,
            imagePath: imagePath,
            width: Responsive.width10 * 5,
            height: Responsive.width10 * 5,
            isActive: isActive,
          ),
          Text(
            petName,
            style: isActive
                ? TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: Responsive.width16,
                  )
                : TextStyle(color: Colors.grey.withOpacity(.7)),
          ),
        ],
      ),
    );
  }
}
