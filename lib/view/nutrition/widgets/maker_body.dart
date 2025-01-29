import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakerBody extends StatefulWidget {
  const MakerBody({
    super.key,
  });

  @override
  State<MakerBody> createState() => _MakerBodyState();
}

class _MakerBodyState extends State<MakerBody> {
  late TextEditingController makerEditingController;
  late TextEditingController givenGramEditingController;
  late TextEditingController numberOfGivenEditingController;

  @override
  void initState() {
    super.initState();

    makerEditingController = TextEditingController();
    numberOfGivenEditingController = TextEditingController();
    givenGramEditingController = TextEditingController();
  }

  @override
  void dispose() {
    makerEditingController.dispose();
    numberOfGivenEditingController.dispose();
    givenGramEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.height10 * .8,
            horizontal: Responsive.width16,
          ),
          child: CustomTextField(
            controller: makerEditingController,
            hintText: AppString.makterText.tr,
            maxLines: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.height10 * .8,
            horizontal: Responsive.width16,
          ),
          child: CustomTextField(
            controller: numberOfGivenEditingController,
            hintText: AppString.numberOfGivenText.tr,
            sufficIcon: Text(
              AppString.numberOfGivenSufficText.tr,
            ),
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.height10 * .8,
            horizontal: Responsive.width16,
          ),
          child: CustomTextField(
            controller: givenGramEditingController,
            hintText: AppString.onceText.tr,
            sufficIcon: Text('g'),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
