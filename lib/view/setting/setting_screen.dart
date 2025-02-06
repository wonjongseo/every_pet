import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/common.dialog.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/calculate_kcal_controller.dart';
import 'package:every_pet/controllers/category_controller.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:every_pet/view/calculate_kcal/edit_groceries_screen.dart';
import 'package:every_pet/view/expensive/change_category_screen.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String settingLanguage = '';
  String displayLanguage = '';
  @override
  void initState() {
    super.initState();
    getSettingLanguage();
  }

  void getSettingLanguage() async {
    settingLanguage =
        await SettingRepository.getString(AppConstant.settingLanguageKey);

    if (settingLanguage.isEmpty) {
      settingLanguage = Get.locale.toString();
      await SettingRepository.setString(
        AppConstant.settingLanguageKey,
        settingLanguage,
      );
    }

    if (settingLanguage.contains('ko')) {
      displayLanguage = AppString.koreanText.tr;
    } else if (settingLanguage.contains('ja')) {
      displayLanguage = AppString.japaneseText.tr;
    } else {
      displayLanguage = AppString.englishText.tr;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log("OPEN SettingScreen");

    return settingLanguage.isEmpty
        ? Container()
        : Column(
            children: [
              SizedBox(height: Responsive.height20),
              _customListTIle(
                title: AppString.editProfile.tr,
                // iconData: FontAwesomeIcons.pencil,
                imagePath: AppImagePath.circleProfile,
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
              ),
              SizedBox(height: Responsive.height15),
              _customListTIle(
                title: AppString.editStampText.tr,
                iconData: FontAwesomeIcons.pencil,
                onTap: () {
                  Get.to(() => StampCustomScreen());
                },
              ),
              SizedBox(height: Responsive.height15),
              _customListTIle(
                title: AppString.editMenuText.tr,
                iconData: FontAwesomeIcons.pencil,
                onTap: () {
                  Get.to(() {
                    Get.put(CalculateKcalController());
                    return const EditGroceriesScreen();
                  });
                },
              ),
              SizedBox(height: Responsive.height15),
              _customListTIle(
                title: AppString.changeCategoryText.tr,
                iconData: FontAwesomeIcons.pencil,
                onTap: () {
                  Get.to(() {
                    Get.put(CategoryController());
                    return const ChangeCategoryScreen();
                  });
                },
              ),
              SizedBox(height: Responsive.height15),
              _customListTIle(
                title: 'Change Language',
                subTitle: AppString.setLanguage.tr,
                iconData: FontAwesomeIcons.earthAfrica,
                onTap: () {},
                widget: DropdownButton(
                    // isDense: true,
                    underline: const SizedBox(),
                    items: [
                      if (AppFunction.isEn()) ...[
                        DropdownMenuItem(
                          value: AppString.koreanText.tr,
                          child: const Text('Korean'),
                        ),
                        DropdownMenuItem(
                          value: AppString.japaneseText.tr,
                          child: const Text('Japenese'),
                        ),
                      ],
                      if (AppFunction.isKo()) ...[
                        DropdownMenuItem(
                          value: AppString.japaneseText.tr,
                          child:
                              Text('Japenese (${AppString.japaneseText.tr})'),
                        ),
                        DropdownMenuItem(
                          value: AppString.englishText.tr,
                          child: Text('English (${AppString.englishText.tr})'),
                        ),
                      ],
                      if (AppFunction.isJp()) ...[
                        DropdownMenuItem(
                          value: AppString.koreanText.tr,
                          child: Text('Korean (${AppString.koreanText.tr})'),
                        ),
                        DropdownMenuItem(
                          value: AppString.englishText.tr,
                          child: Text('English (${AppString.englishText.tr})'),
                        ),
                      ],
                    ],
                    onChanged: changeSystemLanguage),
              ),
              const Spacer(flex: 1),
              _customListTIle(
                title: AppString.fnOrErorreport.tr,
                subTitle: AppString.tipOffMessage.tr,
                iconData: Icons.mail,
                onTap: () async {
                  final Email email = Email(
                    body: AppString.reportMsgContect.tr,
                    subject:
                        '[${AppString.appName.tr}] ${AppString.fnOrErorreport.tr}',
                    recipients: ['visionwill3322@gmail.com'],
                    isHTML: false,
                  );
                  try {
                    await FlutterEmailSender.send(email);
                  } catch (e) {
                    bool result = await CommonDialog.errorNoEnrolledEmail();
                    if (result) {
                      AppFunction.copyWord('visionwill3322@gmail.com');
                    }
                  }
                },
              ),
              const Spacer(flex: 3),
            ],
          );
  }

  void changeSystemLanguage(v) async {
    if (displayLanguage == v) {
      return;
    }
    displayLanguage = v!;

    if (displayLanguage == AppString.koreanText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ko');
      Get.updateLocale(const Locale('ko'));
    } else if (displayLanguage == AppString.japaneseText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ja');
      Get.updateLocale(const Locale('ja'));
    } else {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'en');
      Get.updateLocale(const Locale('en'));
    }
    await Future.delayed(const Duration(milliseconds: 500));

    bool result = await CommonDialog.changeSystemLanguage();

    if (result) {
      exit(0);
    }

    setState(() {});
  }

  Widget _customListTIle({
    required String title,
    String? subTitle,
    IconData? iconData,
    String? imagePath,
    required Function() onTap,
    Widget? widget,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.width15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: ListTile(
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Responsive.width14,
          color: AppColors.black,
        ),
        title: AutoSizeText(
          title,
          maxLines: 1,
        ),
        trailing: widget,
        subtitle: subTitle == null
            ? null
            : AutoSizeText(
                subTitle,
                maxLines: AppFunction.isEn() ? 2 : 1,
              ),
        leading: iconData == null && imagePath != null
            ? Image.asset(
                imagePath,
                width: Responsive.width10 * 4,
                height: Responsive.width10 * 4,
              )
            : Icon(
                iconData,
                color: AppColors.primaryColor,
              ),
        onTap: onTap,
      ),
    );
  }
}
