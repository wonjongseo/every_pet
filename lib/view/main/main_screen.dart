import 'dart:io';
import 'dart:math' as math;

import 'package:every_pet/view/main/widgets/row_pet_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/background2.dart';
import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/controllers/pets_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(
      builder: (petsController) {
        return GestureDetector(
          onTap: petsController.closeBottomSheet,
          child: Scaffold(
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GlobalBannerAdmob(),
                const SizedBox(height: 5),
                bottomNavigationBar(petsController),
              ],
            ),
            body: BackGround2(
              widget: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const TopNavigationBar(),
                    const Divider(height: 10),
                    Expanded(
                      child: petsController.body[petsController.bottomTapIndex],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget topNavigationBar(PetsController petsController) {
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
                      padding: EdgeInsets.only(right: Responsive.width22)
                          .copyWith(top: Platform.isAndroid ? 10 : 0),
                      child: RowPetProfileWidget(
                        petModel: petsController.getPetOfIndex(index)!,
                        isActive: petsController.petPageIndex == index,
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
      selectedFontSize: 10,
      unselectedFontSize: 10,
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

  Widget bottomNavigationBar(PetsController petsController) {
    return NavigationBar(
      height: 60,
      selectedIndex: petsController.bottomTapIndex,
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      onDestinationSelected: petsController.onTapBottomBar,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          );
        },
      ),
      destinations: [
        NavigationDestination(
          label: AppString.calendarTextTr.tr,
          icon: Image.asset(
            AppImagePath.circleCalendar,
            width: Responsive.width10 * 5,
          ),
        ),
        NavigationDestination(
          label: AppString.foodTextTr.tr,
          icon: Image.asset(
            AppImagePath.circleFood,
            width: Responsive.width10 * 5,
          ),
        ),
        NavigationDestination(
          label: AppString.expensiveTextTr.tr,
          icon: Image.asset(
            AppImagePath.circleWallet,
            width: Responsive.width10 * 5,
          ),
        ),
        NavigationDestination(
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

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width10),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.petsLength,
                    (index) {
                      return Padding(
                        padding: EdgeInsets.only(right: Responsive.width15)
                            .copyWith(top: Platform.isAndroid ? 10 : 0),
                        child: RowPetProfileWidget(
                          petModel: controller.getPetOfIndex(index)!,
                          isActive: controller.petPageIndex == index,
                          onTap: () => controller.onTapTopBar(index),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            AddOrRemoveButton(
              onTap: controller.goToEnrollScreen,
              addOrRemove: AddOrRemoveType.ADD,
            ),
          ],
        ),
      );
    });
  }
}
