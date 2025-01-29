import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/view/calculate_kcal/calculate_kcal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HandmadeBody extends StatefulWidget {
  const HandmadeBody({
    super.key,
  });

  @override
  State<HandmadeBody> createState() => _HandmadeBodyState();
}

class _HandmadeBodyState extends State<HandmadeBody> {
  late TextEditingController givenGramEditingController;
  late TextEditingController vegetableEditingController;
  late TextEditingController protinEditingController;

  @override
  void initState() {
    super.initState();

    givenGramEditingController = TextEditingController();
    vegetableEditingController = TextEditingController();
    protinEditingController = TextEditingController();
  }

  @override
  void dispose() {
    givenGramEditingController.dispose();
    vegetableEditingController.dispose();
    protinEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Responsive.height10 * .8,
                horizontal: Responsive.width16,
              ),
              child: CustomTextField(
                controller: givenGramEditingController,
                hintText: AppString.amountGivenGramText.tr,
                sufficIcon: const Text('g'),
                maxLines: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Responsive.height10 * .8,
                horizontal: Responsive.width16,
              ),
              child: CustomTextField(
                controller: vegetableEditingController,
                hintText: AppString.vegetableText.tr,
                sufficIcon: const Text('g'),
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
                controller: protinEditingController,
                hintText: AppString.proteinText.tr,
                sufficIcon: const Text('g'),
                maxLines: 1,
              ),
            ),
          ],
        ),
        Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Get.to(() => CalculateKcalScreen());
                },
                child: Text(AppString.calculateKcalText.tr)))
      ],
    );
  }
}
