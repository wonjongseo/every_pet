import 'dart:io';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/welcome_controller.dart';
import 'package:every_pet/view/calendar/calendar_screen.dart';
import 'package:every_pet/view/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int navigationPageIndex = 0;
  List<Widget> body = [HomeScreen(), Text('栄養画面'), Text('費用画面'), Text('設定画面')];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(builder: (petsController) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top:
                      BorderSide(color: Colors.grey.withOpacity(.5), width: .5),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: navigationPageIndex,
                elevation: 10,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                onTap: tapBottomNavigatoinBar,
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
                    label: '設定',
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
                                padding:
                                    EdgeInsets.only(right: Responsive.width22),
                                child: InkWell(
                                  onTap: () {
                                    petsController.onClickTopBar(index);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: Responsive.width10 * 4.5,
                                        height: Responsive.width10 * 4.5,
                                        decoration: BoxDecoration(
                                          color: petsController.petPageIndex ==
                                                  index
                                              ? AppColors.blueDark
                                              : Colors.grey.withOpacity(.7),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              AppImagePath.bisyon,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        petsController.pets![index].name,
                                        style: petsController.petPageIndex ==
                                                index
                                            ? TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: Responsive.width16,
                                              )
                                            : TextStyle(
                                                color: Colors.grey
                                                    .withOpacity(.7)),
                                      ),
                                    ],
                                  ),
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
                      onPressed: () {
                        Get.to(() => WelcomeScreen());
                      },
                      icon: Icon(Icons.add),
                    )
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: petsController.pets!.length,
                  itemBuilder: (context, index) {
                    return body[navigationPageIndex];
                  },
                ),
              ),
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
      );
    });
  }

  void tapBottomNavigatoinBar(value) {
    navigationPageIndex = value;
    setState(() {});
  }
}
