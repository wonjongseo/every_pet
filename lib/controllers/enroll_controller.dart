import 'dart:developer';
import 'dart:io';

import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/cat_model.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

enum PET_TYPE { DOG, CAT }

class EnrollController extends GetxController {
  final bool isFirst;

  EnrollController(this.isFirst);

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController birthDayEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();
  TextEditingController hospitalNameEditingController = TextEditingController();
  TextEditingController hospitalNumberEditingController =
      TextEditingController();
  TextEditingController groomingNameEditingController = TextEditingController();
  TextEditingController groomingNumberEditingController =
      TextEditingController();

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
    super.onInit();
  }

  @override
  void onReady() async {
    final permission = await PhotoManager.requestPermissionExtend();
    // print('permission');
    // if (!permission.isAuth) Get.back();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // MUST TO FIX
    // nameEditingController.dispose();
    // birthDayEditingController.dispose();
    // weightEditingController.dispose();

    // groomingNameEditingController.dispose();
    // groomingNumberEditingController.dispose();
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
        if (tempFile != null) {
          final directory = await getLibraryDirectory();
          final String path = '${directory.path}/$name.png';
          await tempFile!.copy(path);
        }
      }

      if (petType == PET_TYPE.DOG) {
        DogModel dogModel = DogModel(
            name: name,
            weight: double.parse(weightEditingController.text),
            imageUrl: tempFile != null ? '$name.png' : AppImagePath.bisyon,
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
    if (isFirst) {
      Get.off(() => const MainScreen());
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
      AppFunction.showNoPermissionSnackBar(
          message: AppString.noCameraPermssionMsg.tr);

      // bool result = await CommonDialog.selectionDialog(
      //   title: Text(AppString.requiredText.tr),
      //   connent: Text(AppString.requiredCameraPermssionMsg.tr),
      // );
      // if (result) {
      //   await PhotoManager.openSetting();
      // }
      // AppFunction.showAlertDialog(context: context, message: e.toString());
    }
  }

  String fileName = '';
  File? tempFile;
  void goToImagePickerScreen() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      tempFile = File(image.path);
      imagePath = tempFile!.path;
      fileName = image!.name;
      update();
    } catch (e) {
      AppFunction.showNoPermissionSnackBar(
          message: AppString.noLibaryPermssion.tr);
    }
  }
}
