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
    final ScrollController _scrollController = ScrollController();
    double previousOffset = 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragUpdate: (details) {},
        onVerticalDragEnd: (details) {
          print('details.primaryVelocity : ${details.primaryVelocity}');

          if (details.primaryVelocity! < -500) {
            Get.back();
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              Container(
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
              IconButton(
                onPressed: Get.back,
                icon: const FaIcon(
                  FontAwesomeIcons.x,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
