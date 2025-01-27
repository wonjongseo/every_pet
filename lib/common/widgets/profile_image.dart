import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    this.height,
    this.width,
    this.file,
    this.imagePath,
  }) : super(key: key);

  final double? height;
  final double? width;
  final File? file;
  final String? imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 100,
      width: width ?? 200,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imagePath == null
              ? const AssetImage('assets/images/cute_dog.jpg')
              : FileImage(File(imagePath!)) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
