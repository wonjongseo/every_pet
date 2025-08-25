import 'dart:developer';
import 'dart:io';

import 'package:every_pet/common/admob/interstitial_manager.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/image_path_controller.dart';
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
import 'package:uuid/uuid.dart';

enum PET_TYPE { DOG, CAT }

class EnrollController extends GetxController {
  final bool isFirst;

  EnrollController(this.isFirst);
  ScrollController scrollController = ScrollController();
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

  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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
    scrollController.dispose();
    nameEditingController.dispose();
    birthDayEditingController.dispose();
    weightEditingController.dispose();
    hospitalNameEditingController.dispose();
    hospitalNumberEditingController.dispose();
    groomingNameEditingController.dispose();
    groomingNumberEditingController.dispose();

    super.onClose();
  }

  void onClickSaveBtn(BuildContext context) async {
    if (nameEditingController.text.isEmpty) {
      scrollGoToTop();
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.nameCtrHintText.tr,
      );
      return;
    }

    if (weightEditingController.text.isEmpty) {
      scrollGoToTop();
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.weightCtrHint.tr,
      );
      return;
    }

    if (birthDayEditingController.text.isEmpty) {
      scrollGoToTop();
      AppFunction.showInvalidTextFieldSnackBar(
        message: AppString.birthdayCtrHint.tr,
      );
      return;
    }

    String name = nameEditingController.text;

    if (await petsController.isSavedName(name)) {
      scrollGoToTop();
      AppFunction.showInvalidTextFieldSnackBar(
          message: '$name${AppString.isExistName.tr}');
      return;
    }

    String imageName = const Uuid().v4();
    try {
      if (imagePath != AppImagePath.bisyon &&
          imagePath != AppImagePath.defaultCat) {
        if (tempFile != null) {
          final String path =
              '${Get.find<ImagePathController>().path}/$imageName.png';
          await tempFile!.copy(path);
        }
      }

      if (petType == PET_TYPE.DOG) {
        DogModel dogModel = DogModel(
            name: name,
            weight: double.parse(weightEditingController.text),
            imageUrl: tempFile != null ? '$imageName.png' : AppImagePath.bisyon,
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
          imageUrl:
              tempFile != null ? '$imageName.png' : AppImagePath.defaultCat,
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
      InterstitialManager.instance.maybeShow();
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
      tempFile = File(image.path);
      imagePath = image.path;

      update();
    } catch (e) {
      AppFunction.showNoPermissionSnackBar(
          message: AppString.noCameraPermssionMsg.tr);
    }
  }

  File? tempFile;
  void goToImagePickerScreen() async {
    try {
      tempFile = await AppFunction.goToImagePickerScreen();
      imagePath = tempFile!.path;
      update();
    } catch (e) {
      AppFunction.showNoPermissionSnackBar(
          message: AppString.noLibaryPermssion.tr);
    }
  }
}
