import 'dart:developer';
import 'dart:io';

import 'package:every_pet/common/native_caller.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/cat_model.dart';
import 'package:every_pet/view/enroll/widgets/gender_selector.dart';
import 'package:every_pet/view/full_profile_image_screen.dart';
import 'package:every_pet/view/image_picker_screen.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class EnrollScreenBackup extends StatefulWidget {
  EnrollScreenBackup({super.key, required this.isFirst});
  final bool isFirst;

  @override
  State<EnrollScreenBackup> createState() => _EnrollScreenBackupState();
}

class _EnrollScreenBackupState extends State<EnrollScreenBackup> {
  late TextEditingController nameEditingController;
  late TextEditingController birthDayEditingController;
  late TextEditingController weightEditingController;
  late TextEditingController hospitalNameEditingController;
  late TextEditingController hospitalNumberEditingController;
  late TextEditingController groomingNameEditingController;
  late TextEditingController groomingNumberEditingController;
  GENDER_TYPE genderType = GENDER_TYPE.MALE;
  DateTime? birthDay;
  PetsController petsController = Get.find<PetsController>();
  bool isNeuter = false; // 중성화
  String imagePath = AppImagePath.bisyon;
  bool isPregnancy = false;
  PET_TYPE petType = PET_TYPE.DOG;

  void aa() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();
  }

  void toogleRadio(PET_TYPE? value) {
    if (value == null) return;
    petType = value;

    if (petType == PET_TYPE.DOG) {
      imagePath = AppImagePath.bisyon;
    } else {
      imagePath = AppImagePath.defaultCat;
    }
    setState(() {});
  }

  void togglePregnancy(bool? value) {
    if (value == null) return;

    isPregnancy = value;
    setState(() {});
  }

  void toggleNeuter(bool? value) {
    if (value == null) return;

    isNeuter = value;
    setState(() {});
  }

  void onChangeGendar(GENDER_TYPE? value) {
    if (value == null || value == genderType) {
      return;
    } else {
      isNeuter = false;
      genderType = value;
      setState(() {});
    }
  }

  void selectBirthDayPicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(DateTime.now().year - 20),
      maxTime: DateTime.now(),
      onChanged: (date) {},
      onConfirm: (date) {
        birthDay = date;
        birthDayEditingController.text = AppFunction.getDayYYYYMMDD(birthDay!);
        setState(() {});
      },
      currentTime: DateTime.now(),
      locale: Get.locale.toString().contains('ko')
          ? LocaleType.ko
          : Get.locale.toString().contains('ja')
              ? LocaleType.jp
              : LocaleType.en,
    );
  }

  void pickImageFromCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (image == null) return;
      // imageFile = File(image.path);
      imagePath = image.path;

      setState(() {});
    } catch (e) {
      AppFunction.showAlertDialog(context: context, message: e.toString());
    }
  }

  void goToImagePickerScreen() async {
    try {
      final image = await Get.to(() => const ImagePickerScreen());
      if (image == null) return;

      File file = await AppFunction.uint8ListToFile(image);
      imagePath = file.path;
      setState(() {});
    } catch (e) {
      log('Image Picker Error $e');
    }
  }

  @override
  void initState() {
    nameEditingController = TextEditingController();
    birthDayEditingController = TextEditingController();
    weightEditingController = TextEditingController();
    hospitalNameEditingController = TextEditingController();
    hospitalNumberEditingController = TextEditingController();
    groomingNameEditingController = TextEditingController();
    groomingNumberEditingController = TextEditingController();

    aa();
    super.initState();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    birthDayEditingController.dispose();
    weightEditingController.dispose();
    hospitalNameEditingController.dispose();
    hospitalNumberEditingController.dispose();
    groomingNameEditingController.dispose();
    groomingNumberEditingController.dispose();
    super.dispose();
  }

  void onClickSaveBtn(BuildContext context) async {
    if (nameEditingController.text.isEmpty) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.nameCtrHintText.tr,
      );
      return;
    }

    if (weightEditingController.text.isEmpty) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.weightCtrHint.tr,
      );
      return;
    }

    if (birthDayEditingController.text.isEmpty) {
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.birthdayCtrHint.tr,
      );
      return;
    }

    String name = nameEditingController.text;
    String? savedImagePath;

    try {
      if (imagePath != AppImagePath.bisyon &&
          imagePath != AppImagePath.defaultCat) {
        savedImagePath =
            await AppFunction.saveFileFromTempDirectory(imagePath!, name);
      }

      if (petType == PET_TYPE.DOG) {
        DogModel dogModel = DogModel(
            name: name,
            weight: double.parse(weightEditingController.text),
            imageUrl: savedImagePath ?? AppImagePath.bisyon,
            birthDay: birthDay!,
            genderType: genderType,
            hospitalName: hospitalNameEditingController.text,
            hospitalNumber: hospitalNumberEditingController.text,
            groomingName: groomingNameEditingController.text,
            groomingNumber: groomingNumberEditingController.text);
        await petsController.savePetModal(dogModel);
      } else {
        CatModel catModel = CatModel(
          name: name,
          weight: double.parse(weightEditingController.text),
          imageUrl: savedImagePath ?? AppImagePath.defaultCat,
          birthDay: birthDay!,
          genderType: genderType,
          hospitalName: hospitalNameEditingController.text,
          hospitalNumber: hospitalNumberEditingController.text,
          groomingName: groomingNameEditingController.text,
          groomingNumber: groomingNumberEditingController.text,
        );

        await petsController.savePetModal(catModel);
      }
    } catch (e) {
      log("image Picker error$e");
    }

    await petsController.getPetModals();
    if (widget.isFirst) {
      Get.off(() => const MainScreen());
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    // EnrollController controller = Get.put(EnrollController(widget.isFirst));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => onClickSaveBtn(context),
            icon: const FaIcon(FontAwesomeIcons.check, color: Colors.black),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: SingleChildScrollView(
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
                        groupValue: petType,
                        onChanged: toogleRadio,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text(AppString.catTextTr.tr),
                        value: PET_TYPE.CAT,
                        groupValue: petType,
                        onChanged: toogleRadio,
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
                                  imagePath: imagePath,
                                  onTap: () {
                                    Get.to(
                                      () => FullProfileImageScreen(
                                        imagePath: imagePath,
                                      ),
                                    );
                                  },
                                ),
                                ImagePickIconRow(
                                  onClickCamaraIcon: () =>
                                      pickImageFromCamera(context),
                                  onClickFolderIcon: goToImagePickerScreen,
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.height10 * 2),
                            Form(
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: nameEditingController,
                                    // focusNode: nameEditingFocusNode,
                                    textInputAction: TextInputAction.next,
                                    hintText: AppString.nameTextTr.tr,
                                    fontSize: Responsive.width16,
                                    // validator: nameValidator,
                                  ),
                                  SizedBox(height: Responsive.height14),
                                  CustomTextField(
                                    // focusNode: weightEditingFocusNode,
                                    fontSize: Responsive.width16,
                                    controller: weightEditingController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    hintText: AppString.weightTextTr.tr,
                                    sufficIcon: const Text('kg'),
                                    // validator: weightValidator,
                                  ),
                                  SizedBox(height: Responsive.height14),
                                  CustomTextField(
                                    onTap: () => selectBirthDayPicker(context),
                                    fontSize: Responsive.width16,
                                    // focusNode: birthDayEditingFocusNode,
                                    readOnly: true,
                                    controller: birthDayEditingController,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: Responsive.width10),
                          child: Column(
                            children: [
                              GendarSelector(
                                genderType: genderType,
                                onChangeGender: onChangeGendar,
                              ),
                              SizedBox(height: Responsive.height10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    genderType == GENDER_TYPE.MALE
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
                                      value: isNeuter,
                                      onChanged: toggleNeuter,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: Responsive.height10),
                              if (genderType == GENDER_TYPE.FEMALE)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        value: isPregnancy,
                                        onChanged: togglePregnancy,
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
                                controller: hospitalNameEditingController,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.width10),
                              child: CustomTextField(
                                controller: hospitalNumberEditingController,
                                keyboardType: TextInputType.phone,
                                hintText: AppString.hasipitalNumTextTr.tr,
                                widget: IconButton(
                                  onPressed: hospitalNumberEditingController
                                          .text.isNotEmpty
                                      ? () {
                                          NativeCaller.callPhone(
                                              hospitalNumberEditingController
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
                                controller: groomingNameEditingController,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.width10),
                              child: CustomTextField(
                                controller: groomingNumberEditingController,
                                keyboardType: TextInputType.phone,
                                hintText: AppString.regularTrmingShopNumber.tr,
                                widget: IconButton(
                                  onPressed: groomingNumberEditingController
                                          .text.isNotEmpty
                                      ? () {
                                          NativeCaller.callPhone(
                                              groomingNumberEditingController
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
        )),
      ),
    );
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
