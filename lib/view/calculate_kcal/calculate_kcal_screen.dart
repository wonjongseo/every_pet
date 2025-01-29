import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculateKcalScreen extends StatelessWidget {
  const CalculateKcalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CalculateKcalController());
    return GetBuilder<CalculateKcalController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppString.calculateKcalText.tr),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                  controller.pet.getDER().toString(),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }
}
