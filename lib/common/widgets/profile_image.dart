import 'dart:developer';
import 'dart:io';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:flutter/material.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.height,
    this.width,
    this.file,
    this.imagePath,
    this.genderType,
    this.isActive,
    this.onLongPress,
    required this.onTap,
  }) : super(key: key);

  final double? height;
  final double? width;
  final File? file;
  final String? imagePath;
  final bool? isActive;
  final GENDER_TYPE? genderType;
  final Function() onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: height ?? 200,
        width: width ?? 200,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isActive ?? false
              ? AppColors.primaryColor
              : Colors.grey.withOpacity(.7),
          border: isActive ?? false
              ? Border.all(color: AppColors.primaryColor, width: 4)
              : genderType == null
                  ? Border.all(color: Colors.grey.withOpacity(.7))
                  : genderType! == GENDER_TYPE.MALE
                      ? Border.all(color: Colors.blueAccent, width: 2)
                      : Border.all(color: Colors.redAccent, width: 2),
          shape: BoxShape.circle,
          image: DecorationImage(
            onError: (exception, stackTrace) {
              log(exception.toString());
            },
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
