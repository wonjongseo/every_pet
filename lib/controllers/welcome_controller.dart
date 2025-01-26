import 'dart:io';
import 'dart:typed_data';

import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/view/image_picker_screen.dart';
import 'package:every_pet/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class WelcomeController extends GetxController {
  late TextEditingController nameEditingController;
  late TextEditingController birthDayEditingController;
  late TextEditingController weightEditingController;

  late FocusNode nameEditingFocusNode;
  late FocusNode birthDayEditingFocusNode;
  late FocusNode weightEditingFocusNode;

  PetRepository petRepository = PetRepository();
  final formKey = GlobalKey<FormState>();

  DateTime? birthDay;

  GENDER_TYPE genderType = GENDER_TYPE.MALE;
  bool isNeuter = false; // 중성화

  bool isPregnancy = false;

  @override
  void onInit() {
    nameEditingController = TextEditingController(text: '');
    birthDayEditingController = TextEditingController();
    weightEditingController = TextEditingController(text: '');

    nameEditingFocusNode = FocusNode();
    birthDayEditingFocusNode = FocusNode();
    weightEditingFocusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    nameEditingController.dispose();
    birthDayEditingController.dispose();
    weightEditingController.dispose();

    nameEditingFocusNode.dispose();
    birthDayEditingFocusNode.dispose();
    weightEditingFocusNode.dispose();
    super.onClose();
  }

  void onClickSaveBtn(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String name = nameEditingController.text;
    File? savedFile = null;

    if (imageFile != null) {
      savedFile =
          await UtilFunction.saveFileFromTempDirectory(imageFile!, name);
    }

    print('weightEditingController.text : ${weightEditingController.text}');

    DogModel dogModel = DogModel(
      name: name,
      weight: int.parse(weightEditingController.text),
      imageUrl: imageFile != null && savedFile != null ? savedFile.path : '',
      birthDay: birthDay!,
      genderType: genderType,
    );

    petRepository.saveDog(dogModel);

    Get.to(() => ProfileScreen());
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
      onChanged: (date) {
        print('change $date');
      },
      onConfirm: (date) {
        birthDay = date;
        birthDayEditingController.text = UtilFunction.getDayYYYYMMDD(birthDay!);
        update();
      },
      currentTime: DateTime.now(),
      locale: LocaleType.zh,
    );
  }

  File? imageFile;

  void pickImageFromCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      imageFile = File(image.path);

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
    imageFile = file;
    update();
  }
}
