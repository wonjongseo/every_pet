import 'dart:io';
import 'dart:typed_data';

import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/cat_model.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/view/image_picker_screen.dart';
import 'package:every_pet/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

enum PET_TYPE { DOG, CAT }

class EnrollController extends GetxController {
  final bool isFirst;

  EnrollController(this.isFirst);

  late TextEditingController nameEditingController;
  late TextEditingController birthDayEditingController;
  late TextEditingController weightEditingController;

  late FocusNode nameEditingFocusNode;
  late FocusNode birthDayEditingFocusNode;
  late FocusNode weightEditingFocusNode;

  late GlobalKey<FormState> formKey;
  DateTime? birthDay;
  PetsController petsController = Get.find<PetsController>();
  GENDER_TYPE genderType = GENDER_TYPE.MALE;
  bool isNeuter = false; // 중성화

  bool isPregnancy = false;

  // File? imageFile;
  String? imagePath;
  PET_TYPE petType = PET_TYPE.DOG;

  void toogleRadio(PET_TYPE? value) {
    if (value == null) return;
    petType = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    formKey = GlobalKey<FormState>();

    nameEditingController = TextEditingController();
    birthDayEditingController = TextEditingController();
    weightEditingController = TextEditingController();

    nameEditingFocusNode = FocusNode();
    birthDayEditingFocusNode = FocusNode();
    weightEditingFocusNode = FocusNode();
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.nameCtrHintText.tr;
    }

    if (petsController.pets == null) {
      return null;
    } else {
      for (var pet in petsController.pets!) {
        if (pet.name == value) {
          return '$value${AppString.duplicateName.tr}';
        }
      }
    }

    return null;
  }

  String? weightValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.weightCtrHint.tr;
    }
    return null;
  }

  String? birthDayValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.birthdayCtrHint.tr;
    }
    return null;
  }

  @override
  void onClose() {
    super.onClose();
    print('enrollController onClose');
    nameEditingController.dispose();
    birthDayEditingController.dispose();
    weightEditingController.dispose();

    nameEditingFocusNode.dispose();
    birthDayEditingFocusNode.dispose();
    weightEditingFocusNode.dispose();
  }

  void onClickSaveBtn(BuildContext context) async {
    print('formKey : ${formKey}');

    if (!formKey.currentState!.validate()) {
      return;
    }

    String name = nameEditingController.text;
    String? savedImagePath = null;

    if (imagePath != null) {
      savedImagePath =
          await UtilFunction.saveFileFromTempDirectory(imagePath!, name);
    }

    if (petType == PET_TYPE.DOG) {
      DogModel dogModel = DogModel(
        name: name,
        weight: double.parse(weightEditingController.text),
        imageUrl:
            imagePath != null && savedImagePath != null ? savedImagePath : '',
        birthDay: birthDay!,
        genderType: genderType,
      );
      await petsController.savePetModal(dogModel);
    } else {
      CatModel catModel = CatModel(
        name: name,
        weight: double.parse(weightEditingController.text),
        imageUrl:
            imagePath != null && savedImagePath != null ? savedImagePath : '',
        birthDay: birthDay!,
        genderType: genderType,
      );

      await petsController.savePetModal(catModel);
    }

    if (!isFirst) {
      petsController.increasePetPageIndex();
    }
    Get.offAll(() => const MainScreen());
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
    print(value);
    if (value == null || value! == genderType) {
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
        birthDayEditingController.text = UtilFunction.getDayYYYYMMDD(birthDay!);
        update();
      },
      currentTime: DateTime.now(),
      locale: LocaleType.zh,
    );
  }

  void pickImageFromCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      // imageFile = File(image.path);
      imagePath = image.path;

      update();
    } catch (e) {
      print('e.toString() : ${e.toString()}');

      UtilFunction.showAlertDialog(context: context, message: e.toString());
    }
  }

  void goToImagePickerScreen() async {
    final image = await Get.to(() => ImagePickerScreen());
    if (image == null) return;

    File file = await UtilFunction.uint8ListToFile(image);
    // imageGallery = image;
    // imageFile = file;
    imagePath = file.path;
    update();
  }
}
