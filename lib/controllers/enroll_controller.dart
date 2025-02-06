import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/cat_model.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/view/image_picker_screen.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

enum PET_TYPE { DOG, CAT }

class EnrollController extends GetxController {
  final bool isFirst;

  EnrollController(this.isFirst);

  late TextEditingController nameEditingController;
  late TextEditingController birthDayEditingController;
  late TextEditingController weightEditingController;
  late TextEditingController hospitalNameEditingController;
  late TextEditingController hospitalNumberEditingController;

  late TextEditingController groomingNameEditingController;
  late TextEditingController groomingNumberEditingController;

  // late FocusNode nameEditingFocusNode;
  // late FocusNode birthDayEditingFocusNode;
  // late FocusNode weightEditingFocusNode;

  DateTime? birthDay;
  PetsController petsController = Get.find<PetsController>();
  GENDER_TYPE genderType = GENDER_TYPE.MALE;
  bool isNeuter = false; // 중성화

  bool isPregnancy = false;

  // File? imageFile;
  String imagePath = AppImagePath.bisyon;
  PET_TYPE petType = PET_TYPE.DOG;

  void toogleRadio(PET_TYPE? value) {
    if (value == null) return;
    petType = value;

    if (petType == PET_TYPE.DOG) {
      imagePath = AppImagePath.bisyon;
    } else {
      imagePath = AppImagePath.defaultCat;
    }
    update();
  }

  @override
  void onInit() {
    nameEditingController = TextEditingController();
    birthDayEditingController = TextEditingController();
    weightEditingController = TextEditingController();
    hospitalNameEditingController = TextEditingController();
    hospitalNumberEditingController = TextEditingController();
    groomingNameEditingController = TextEditingController();
    groomingNumberEditingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameEditingController.dispose();
    birthDayEditingController.dispose();
    weightEditingController.dispose();

    groomingNameEditingController.dispose();
    groomingNumberEditingController.dispose();
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
            groomingNumber: groomingNameEditingController.text);
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
          groomingNumber: groomingNameEditingController.text,
        );

        await petsController.savePetModal(catModel);
      }
    } catch (e) {
      log("image Picker error$e");
    }

    await petsController.getPetModals();
    if (isFirst) {
      Get.off(() => const MainScreen());
      // if (Get.isRegistered<EnrollController>()) {
      //   print(
      //       'Get.isRegistered<EnrollController>() : ${Get.isRegistered<EnrollController>()}');

      //   await Get.delete<EnrollController>();

      //   print(
      //       'Get.isRegistered<EnrollController>() : ${Get.isRegistered<EnrollController>()}');
      // }
    } else {
      Get.back();
    }
  }

  void togglePregnancy(bool? value) {
    if (value == null) return;

    isPregnancy = value;
    update();
  }

  void toggleNeuter(bool? value) {
    if (value == null) return;

    isNeuter = value;
    update();
  }

  void onChangeGendar(GENDER_TYPE? value) {
    if (value == null || value == genderType) {
      return;
    } else {
      isNeuter = false;
      genderType = value;
      update();
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
        update();
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

      update();
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
      update();
    } catch (e) {
      log('Image Picker Error $e');
    }
  }
}
