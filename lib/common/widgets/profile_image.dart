import 'dart:io';

import 'package:flutter/material.dart';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/controllers/enroll_controller.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.height,
    this.width,
    this.file,
    this.imagePath,
    this.isActive,
    required this.isDog,
  }) : super(key: key);

  final double? height;
  final double? width;
  final File? file;
  final String? imagePath;
  final bool? isActive;

  final bool isDog;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100,
      width: width ?? 200,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isActive ?? false
            ? AppColors.primaryColor
            : Colors.grey.withOpacity(.7),
        border: isActive ?? false
            ? Border.all(
                color: AppColors.primaryColor,
                width: 3,
              )
            : Border.all(
                color: Colors.grey.withOpacity(.7),
              ),
        shape: BoxShape.circle,
        image: DecorationImage(
          onError: (exception, stackTrace) {},
          image: imagePath == null || imagePath!.isEmpty
              ? AssetImage(
                  isDog ? AppImagePath.bisyon : AppImagePath.defaultCat,
                )
              : FileImage(File(imagePath!)) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
