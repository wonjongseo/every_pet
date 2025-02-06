import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/view/full_profile_image_screen.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.height,
    this.width,
    this.file,
    this.imagePath,
    this.isActive,
    required this.onTap,
  }) : super(key: key);

  final double? height;
  final double? width;
  final File? file;
  final String? imagePath;
  final bool? isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 200,
        width: width ?? 200,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isActive ?? false
              ? AppColors.primaryColor
              : Colors.grey.withOpacity(.7),
          border: isActive ?? false
              ? Border.all(color: AppColors.primaryColor, width: 3)
              : Border.all(color: Colors.grey.withOpacity(.7)),
          shape: BoxShape.circle,
          image: DecorationImage(
            onError: (exception, stackTrace) {},
            image: imagePath == AppImagePath.bisyon ||
                    imagePath == AppImagePath.defaultCat
                ? AssetImage(imagePath!)
                : FileImage(File(imagePath!)) as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
