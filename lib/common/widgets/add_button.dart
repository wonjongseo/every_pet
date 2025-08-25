import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:flutter/material.dart';

enum AddOrRemoveType { ADD, REMOVE }

class AddOrRemoveButton extends StatelessWidget {
  AddOrRemoveButton({
    super.key,
    this.onTap,
    this.width,
    this.isSelected = false,
    required this.addOrRemove,
  });

  final AddOrRemoveType addOrRemove;
  Function()? onTap;
  final double? width;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.orange[400] ?? Colors.orange,
            blurRadius: 5,
            spreadRadius: .01,
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Responsive.width10 * 5),
        onTap: onTap,
        child: Image.asset(
          addOrRemove == AddOrRemoveType.ADD
              ? AppImagePath.circleAddBtn
              : AppImagePath.circleRemoteBtn,
          width: width ?? Responsive.width10 * 4.5,
          height: width ?? Responsive.width10 * 4.5,
          color: isSelected ? Colors.white.withOpacity(.5) : null,
          colorBlendMode: isSelected ? BlendMode.modulate : null,
        ),
      ),
    );
  }
}
