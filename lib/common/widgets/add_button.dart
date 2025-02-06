import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:flutter/material.dart';

enum AddOrRemoveType { ADD, REMOTE }

class AddOrRemoveButton extends StatelessWidget {
  const AddOrRemoveButton({
    super.key,
    required this.onTap,
    this.width,
    this.height,
    required this.addOrRemove,
  });

  final AddOrRemoveType addOrRemove;
  final Function() onTap;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        addOrRemove == AddOrRemoveType.ADD
            ? AppImagePath.circleAddBtn
            : AppImagePath.circleRemoteBtn,
        width: width ?? Responsive.width10 * 4.5,
        height: height ?? Responsive.width10 * 4.5,
      ),
    );
  }
}
