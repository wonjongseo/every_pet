import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('プロフィール編集'),
          onTap: () {
            Get.to(() => ProfileScreen());
          },
        ),
        ListTile(
          title: Text('言語選択'),
          onTap: () {
            // Get.to(() => ProfileScreen());
          },
        )
      ],
    );
  }
}
