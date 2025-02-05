import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
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
    print('settingLanguage : ${settingLanguage}');

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
      displayLanguage = AppString.koreanText.tr;
    }
    print('displayLanguage : ${displayLanguage}');

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
                iconData: FontAwesomeIcons.pencil,
                onTap: () {
                  Get.to(() => ProfileScreen());
                },
              ),
              SizedBox(height: Responsive.height10),
              _customListTIle(
                title: AppString.editStampText.tr,
                iconData: FontAwesomeIcons.pencil,
                onTap: () {
                  Get.to(() => StampCustomScreen());
                },
              ),
              SizedBox(height: Responsive.height10),
              _customListTIle(
                title: AppString.editMenuText.tr,
                iconData: FontAwesomeIcons.pencil,
                onTap: () {
                  Get.to(() {
                    Get.put(CalculateKcalController());
                    return EditGroceriesScreen();
                  });
                },
              ),
              SizedBox(height: Responsive.height10),
              _customListTIle(
                title: AppString.changeCategoryText.tr,
                iconData: FontAwesomeIcons.pencil,
                onTap: () {
                  Get.to(() {
                    Get.put(CategoryController());
                    return ChangeCategoryScreen();
                  });
                },
              ),
              SizedBox(height: Responsive.height10),
              _customListTIle(
                  title: 'Change System Language',
                  subTitle: AppString.setLanguage.tr,
                  iconData: FontAwesomeIcons.earthAfrica,
                  onTap: () {},
                  widget: DropdownButton(
                      underline: const SizedBox(),
                      items: [
                        if (displayLanguage == AppString.koreanText.tr) ...[
                          DropdownMenuItem(
                            value: AppString.japaneseText.tr,
                            child:
                                Text('Japenese (${AppString.japaneseText.tr})'),
                          ),
                          DropdownMenuItem(
                            value: AppString.koreanText.tr,
                            child: Text('Korean (${AppString.koreanText.tr})'),
                          ),
                        ] else ...[
                          DropdownMenuItem(
                            value: AppString.koreanText.tr,
                            child: Text('Korean (${AppString.koreanText.tr})'),
                          ),
                          DropdownMenuItem(
                            value: AppString.japaneseText.tr,
                            child:
                                Text('Japenese (${AppString.japaneseText.tr})'),
                          ),
                        ]
                      ],
                      onChanged: changeSystemLanguage)),
              Spacer(flex: 1),
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
              Spacer(flex: 3),
            ],
          );
  }

  void changeSystemLanguage(v) async {
    displayLanguage = v!;

    // Get.deleteAll(); // Dont' delete

    if (displayLanguage == AppString.koreanText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ko');
      Get.updateLocale(const Locale('ko'));

      AppFunction.showMessageSnackBar(
        title: '완료',
        message: '시스템 언어가 변경되었습니다.\n폰트를 적용 시키려면 앱을 재기동 해주세요.',
        duration: Duration(milliseconds: 7000),
      );
    } else if (displayLanguage == AppString.japaneseText.tr) {
      await SettingRepository.setString(AppConstant.settingLanguageKey, 'ja');
      Get.updateLocale(const Locale('ja'));
      AppFunction.showMessageSnackBar(
        title: '完了',
        message: 'システム言語が変更されました。\nフォントを適用させるにはアプリを再起動してください。',
        duration: Duration(milliseconds: 7000),
      );
    }

    setState(() {});
  }

  Widget _customListTIle({
    required String title,
    String? subTitle,
    required IconData iconData,
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
                maxLines: 1,
              ),
        leading: Icon(
          iconData,
          color: AppColors.primaryColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
