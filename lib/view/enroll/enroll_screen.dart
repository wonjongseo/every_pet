import 'dart:io';

import 'package:every_pet/background2.dart';
import 'package:every_pet/common/native_caller.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/view/enroll/widgets/gender_selector.dart';
import 'package:every_pet/view/full_profile_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';

class EnrollScreen extends StatelessWidget {
  const EnrollScreen({super.key, required this.isFirst});
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    EnrollController controller = Get.put(EnrollController(isFirst));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              controller.onClickSaveBtn(context);
            },
            icon: const FaIcon(FontAwesomeIcons.check, color: Colors.black),
          )
        ],
      ),
      body: BackGround2(
        widget: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: GetBuilder<EnrollController>(
              builder: (controller) {
                return EnrollScreenBody(controller: controller);
              },
            ),
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text(AppString.dogTextTr.tr),
                    value: PET_TYPE.DOG,
                    groupValue: controller.petType,
                    onChanged: controller.toogleRadio,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text(AppString.catTextTr.tr),
                    value: PET_TYPE.CAT,
                    groupValue: controller.petType,
                    onChanged: controller.toogleRadio,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Responsive.height16 * 2,
                horizontal: Responsive.width16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            ProfileImage(
                              imagePath: controller.imagePath,
                              onTap: () {
                                Get.to(
                                  () => FullProfileImageScreen(
                                    imagePath: controller.imagePath,
                                  ),
                                );
                              },
                            ),
                            ImagePickIconRow(
                              onClickCamaraIcon: () =>
                                  controller.pickImageFromCamera(context),
                              onClickFolderIcon:
                                  controller.goToImagePickerScreen,
                            ),
                          ],
                        ),
                        SizedBox(height: Responsive.height10 * 2),
                        Form(
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: controller.nameEditingController,
                                textInputAction: TextInputAction.next,
                                hintText: AppString.nameTextTr.tr,
                                fontSize: Responsive.width16,
                                // validator: controller.nameValidator,
                              ),
                              SizedBox(height: Responsive.height14),
                              CustomTextField(
                                // focusNode: controller.weightEditingFocusNode,
                                fontSize: Responsive.width16,
                                controller: controller.weightEditingController,
                                textInputAction: TextInputAction.next,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                hintText: AppString.weightTextTr.tr,
                                sufficIcon: const Text('kg'),
                                // validator: controller.weightValidator,
                              ),
                              SizedBox(height: Responsive.height14),
                              CustomTextField(
                                onTap: () =>
                                    controller.selectBirthDayPicker(context),
                                fontSize: Responsive.width16,
                                // focusNode: controller.birthDayEditingFocusNode,
                                readOnly: true,
                                controller:
                                    controller.birthDayEditingController,
                                hintText: AppString.birthDayTextTr.tr,
                                // validator: controller.birthDayValidator,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: Responsive.height10 * 4),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Responsive.width10),
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
                                    ? AppString.kyoseiTr.tr
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
                          if (controller.genderType == GENDER_TYPE.FEMALE)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppString.pregentText.tr,
                                  style: TextStyle(
                                    fontSize: Responsive.width16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Transform.scale(
                                  scale: 1.25,
                                  child: Checkbox(
                                    value: controller.isPregnancy,
                                    onChanged: controller.togglePregnancy,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                    Divider(height: Responsive.height10 * 4),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: Responsive.width10 / 2),
                            Text(
                              AppString.regularHospital.tr,
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
                            hintText: AppString.hasipitalTextTr.tr,
                            textInputAction: TextInputAction.next,
                            controller:
                                controller.hospitalNameEditingController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Responsive.width10),
                          child: CustomTextField(
                            controller:
                                controller.hospitalNumberEditingController,
                            keyboardType: TextInputType.phone,
                            hintText: AppString.hasipitalNumTextTr.tr,
                            widget: IconButton(
                              onPressed: controller
                                      .hospitalNumberEditingController
                                      .text
                                      .isNotEmpty
                                  ? () {
                                      NativeCaller.callPhone(controller
                                          .hospitalNumberEditingController
                                          .text);
                                    }
                                  : null,
                              icon: const Icon(Icons.phone),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.height10 * 4),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: Responsive.width10 / 2),
                            Text(
                              AppString.regularTrmingShop.tr,
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
                            hintText: AppString.regularTrmingShopName.tr,
                            textInputAction: TextInputAction.next,
                            controller:
                                controller.groomingNameEditingController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Responsive.width10),
                          child: CustomTextField(
                            controller:
                                controller.groomingNumberEditingController,
                            keyboardType: TextInputType.phone,
                            hintText: AppString.regularTrmingShopNumber.tr,
                            widget: IconButton(
                              onPressed: controller
                                      .groomingNumberEditingController
                                      .text
                                      .isNotEmpty
                                  ? () {
                                      NativeCaller.callPhone(controller
                                          .groomingNumberEditingController
                                          .text);
                                    }
                                  : null,
                              icon: const Icon(Icons.phone),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onClickCamaraIcon,
          icon: Icon(
            Icons.camera_alt,
            size: Responsive.width10 * 3,
          ),
        ),
        SizedBox(width: Responsive.width10),
        IconButton(
          onPressed: onClickFolderIcon,
          icon: Icon(
            Icons.folder_copy,
            size: Responsive.width10 * 3,
          ),
        )
      ],
    );
  }
}
