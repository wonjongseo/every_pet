import 'package:every_pet/controllers/main_controller.dart';
import 'package:every_pet/view/main/widgets/top_navi_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/background2.dart';
import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            bottomNavigationBar(),
            const SizedBox(height: 5),
            const GlobalBannerAdmob(),
          ],
        ),
        body: BackGround2(
          widget: SafeArea(
            child: Column(
              children: [
                const TopNaviBar(),
                const Divider(height: 10),
                Obx(
                  () => Expanded(
                    child: controller.body[controller.bottomTapIndex.value],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Obx(() => NavigationBar(
          height: 50,
          labelPadding: EdgeInsets.zero,
          selectedIndex: controller.bottomTapIndex.value,
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          onDestinationSelected: controller.onTapBottomBar,
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
        ));
  }
}
