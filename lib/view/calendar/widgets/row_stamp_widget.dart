import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:flutter/material.dart';

class RowStampWidget extends StatelessWidget {
  const RowStampWidget({
    super.key,
    required this.stamp,
  });

  final StampModel stamp;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.blueLight.withOpacity(.5),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            stamp.getIcon(),
          ),
        ),
        SizedBox(width: Responsive.width10),
        Text(
          stamp.name,
        ),
      ],
    );
  }
}
