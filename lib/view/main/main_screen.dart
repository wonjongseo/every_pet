import 'dart:io';

import 'package:every_pet/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:every_pet/view/todo/todo_screen.dart';

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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.withOpacity(.5),
                      width: .5,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: petsController.bottomTapIndex,
                  elevation: 10,
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  onTap: petsController.onTapBottomBar,
                  unselectedLabelStyle: TextStyle(color: Colors.red),
                  selectedLabelStyle: TextStyle(color: Colors.red),
                  selectedIconTheme: IconThemeData(color: Colors.red),
                  items: [
                    BottomNavigationBarItem(
                      label: 'カレンダー',
                      icon: Image.asset(
                        AppImagePath.circleCalendar,
                        width: Responsive.width10 * 5,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: '栄養',
                      icon: Image.asset(
                        AppImagePath.circleFood,
                        width: Responsive.width10 * 5,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: '費用',
                      icon: Image.asset(
                        AppImagePath.circleWallet,
                        width: Responsive.width10 * 5,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: AppString.setting.tr,
                      icon: Image.asset(
                        AppImagePath.circleSetting,
                        width: Responsive.width10 * 5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: double.infinity,
                child: Text(
                  'This is AD',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                color: Colors.yellow,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.width14,
                    vertical: Responsive.height10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              petsController.pets!.length,
                              (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: Responsive.width22),
                                  child: RowPetProfileWidget(
                                    isDog: petsController
                                            .pets![index].runtimeType ==
                                        DogModel,
                                    petName: petsController.pets![index].name,
                                    isActive:
                                        petsController.petPageIndex == index,
                                    imagePath:
                                        petsController.pets![index].imageUrl,
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
                      IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.blueDark,
                            foregroundColor: AppColors.backgroundLight),
                        onPressed: petsController.goToEnrollScreen,
                        icon: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: petsController.body[petsController.bottomTapIndex],
                )
                // Expanded(
                //   child: PageView.builder(
                //     itemCount: petsController.pets!.length,
                //     itemBuilder: (context, index) {
                //       return petsController.body[petsController.bottomTapIndex];
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          // body: SafeArea(
          //   child: TabBarView(
          //     children: List.generate(
          //       petsController.pets!.length,
          //       (index) => body[navigationPageIndex],
          //     ),
          //   ),
          // ),
        ),
      );
    });
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
            width: Responsive.width10 * 4.5,
            height: Responsive.width10 * 4.5,
            isActive: isActive,
          ),
          // Container(
          //   width: Responsive.width10 * 4.5,
          //   height: Responsive.width10 * 4.5,
          //   decoration: BoxDecoration(
          //     color:
          //         isActive ? AppColors.blueDark : Colors.grey.withOpacity(.7),
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: AssetImage(
          //         AppImagePath.bisyon,
          //       ),
          //     ),
          //   ),
          // ),
          Text(
            petName,
            // style: petsController.petPageIndex == index
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
