import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:flutter/material.dart';

class RowStampWidget extends StatelessWidget {
  const RowStampWidget({
    super.key,
    required this.stamp,
    required this.isExsit,
  });
  final bool isExsit;
  final StampModel stamp;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: Responsive.width10 * 4,
              width: Responsive.width10 * 4,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(.5),
                shape: BoxShape.circle,
              ),
              child: Image.asset(StampModel.getIcon(stamp.iconIndex)),
            ),
            SizedBox(width: Responsive.width10),
            Text(stamp.name),
          ],
        ),
        if (!isExsit)
          AddOrRemoveButton(
            addOrRemove: AddOrRemoveType.REMOVE,
            width: Responsive.width10 * 4,
          )
      ],
    );
  }
}
