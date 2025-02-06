import 'dart:io';

import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FullProfileImageScreen extends StatelessWidget {
  const FullProfileImageScreen({super.key, required this.imagePath});

  final String imagePath;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const FaIcon(
            FontAwesomeIcons.x,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imagePath == AppImagePath.bisyon ||
                    imagePath == AppImagePath.defaultCat
                ? AssetImage(imagePath)
                : FileImage(
                    File(imagePath),
                  ) as ImageProvider,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
