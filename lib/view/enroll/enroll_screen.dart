import 'dart:io';

import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/view/enroll/widgets/gender_selector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/view/image_picker_screen.dart';

class EnrollScreen extends StatelessWidget {
  EnrollScreen({super.key, required this.isFirst});
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    // EnrollController controller = Get.find<EnrollController>();
    EnrollController controller = Get.put(EnrollController(isFirst));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => controller.onClickSaveBtn(context),
            icon: const FaIcon(FontAwesomeIcons.check, color: Colors.black),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: GetBuilder<EnrollController>(
            builder: (controller) {
              return EnrollScreenBody(controller: controller);
            },
          ),
        ),
      ),
    );
  }
}

class EnrollScreenBody extends StatelessWidget {
  const EnrollScreenBody({
    super.key,
    required this.controller,
  });

  final EnrollController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                title: const Text('犬'),
                value: PET_TYPE.DOG,
                groupValue: controller.petType,
                onChanged: controller.toogleRadio,
              ),
            ),
            Expanded(
              child: RadioListTile(
                title: const Text('猫'),
                value: PET_TYPE.CAT,
                groupValue: controller.petType,
                onChanged: controller.toogleRadio,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          ProfileImage(
                            imagePath: controller.imagePath,
                            isDog: controller.petType == PET_TYPE.DOG,
                          ),
                          ImagePickIconRow(
                            onClickCamaraIcon: () {
                              controller.pickImageFromCamera(context);
                            },
                            onClickFolderIcon: controller.goToImagePickerScreen,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Responsive.width10),
                    Expanded(
                      flex: 5,
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: controller.nameEditingController,
                              focusNode: controller.nameEditingFocusNode,
                              textInputAction: TextInputAction.next,
                              hintText: AppString.nameText.tr,
                              fontSize: Responsive.width16,
                              validator: controller.nameValidator,
                            ),
                            SizedBox(height: Responsive.height14),
                            CustomTextField(
                              focusNode: controller.weightEditingFocusNode,
                              fontSize: Responsive.width16,
                              controller: controller.weightEditingController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              hintText: AppString.weightText.tr,
                              sufficIcon: const Text('kg'),
                              validator: controller.weightValidator,
                            ),
                            SizedBox(height: Responsive.height14),
                            CustomTextField(
                              onTap: () =>
                                  controller.selectBirthDayPicker(context),
                              fontSize: Responsive.width16,
                              focusNode: controller.birthDayEditingFocusNode,
                              readOnly: true,
                              controller: controller.birthDayEditingController,
                              hintText: AppString.birthDayText.tr,
                              validator: controller.birthDayValidator,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: Responsive.height10 * 4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.width10),
                  child: Column(
                    children: [
                      GendarSelector(
                        genderType: controller.genderType,
                        onChangeGender: controller.onChangeGendar,
                      ),
                      SizedBox(height: Responsive.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.genderType == GENDER_TYPE.MALE
                                ? AppString.fuinnTr.tr
                                : AppString.fuinnTr.tr,
                            style: TextStyle(
                              fontSize: Responsive.width16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Transform.scale(
                            scale: 1.25,
                            child: Checkbox(
                              value: controller.isNeuter,
                              onChanged: controller.toggleNeuter,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: Responsive.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.pregentTextTr.tr,
                            style: TextStyle(
                              fontSize: Responsive.width16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Transform.scale(
                            scale: 1.25,
                            child: Checkbox(
                              value: controller.genderType == GENDER_TYPE.FEMALE
                                  ? controller.isPregnancy
                                  : false,
                              onChanged:
                                  controller.genderType == GENDER_TYPE.FEMALE
                                      ? controller.togglePregnancy
                                      : null,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                SizedBox(height: Responsive.height10 * 2),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Responsive.width10 * 2.5,
                          height: Responsive.width10 * 2.5,
                          decoration: BoxDecoration(
                            color: AppColors.greenDark,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Responsive.width10 * .4),
                            ),
                          ),
                        ),
                        SizedBox(width: Responsive.width10 / 2),
                        Text(
                          AppString.kakaridukebyouinn.tr,
                          style: TextStyle(
                            fontSize: Responsive.width18,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.width10,
                        vertical: Responsive.height10,
                      ),
                      child: CustomTextField(
                        hintText: AppString.hasipitalCtrHintTr.tr,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Responsive.width10),
                      child: CustomTextField(
                        hintText: AppString.hasipitalNumCtrHintTr.tr,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );

    // return GetBuilder<EnrollController>(builder: (controller) {

    // });
  }
}

class ImagePickIconRow extends StatelessWidget {
  const ImagePickIconRow({
    super.key,
    required this.onClickCamaraIcon,
    required this.onClickFolderIcon,
  });

  final VoidCallback onClickCamaraIcon;
  final VoidCallback onClickFolderIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: onClickCamaraIcon,
          icon: const Icon(Icons.camera_alt),
        ),
        IconButton(
          onPressed: onClickFolderIcon,
          icon: const Icon(Icons.folder_copy),
        )
      ],
    );
  }
}
