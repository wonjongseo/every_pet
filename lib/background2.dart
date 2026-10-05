import 'dart:io';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/view/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

class BackGround2 extends StatelessWidget {
  const BackGround2({
    super.key,
    required this.widget,
  });
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    int randomTop1 = 120; // 120
    int randomTop2 = 410; // 410
    return Obx(() {
      final controller = SettingController.to;
      final opacity = controller.backgroundOpacity;
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: -120,
              right: 120,
              top: randomTop1.toDouble(),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Transform.scale(
                  scale: 0.7,
                  child: _backgroundImage(controller, opacity),
                ),
              ),
            ),
            Positioned(
              left: 120,
              right: -120,
              // top: 400,
              top: randomTop2.toDouble(),
              child: _backgroundImage(controller, opacity),
            ),
            widget,
          ],
        ),
      );
    });
  }

  Widget _backgroundImage(SettingController controller, double opacity) {
    final image = controller.backgroundImageSource ==
            AppConstant.backgroundImageSourceFile
        ? Image.file(
            File(controller.backgroundImagePath),
            fit: BoxFit.fill,
            errorBuilder: (_, __, ___) => Image.asset(
              AppImagePath.bisyon,
              fit: BoxFit.fill,
            ),
          )
        : Image.asset(
            controller.backgroundImagePath,
            fit: BoxFit.fill,
          );

    return Opacity(
      opacity: opacity,
      child: image,
    );
  }
}
