import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileController extends EnrollController {
  // late PetsController petsController;

  PetRepository petRepository = PetRepository();
  ProfileController() : super(false);

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  loadPetInfo(PetModel pet) {
    // petsController = Get.find<PetsController>();

    nameEditingController = TextEditingController(text: pet.name);
    birthDayEditingController =
        TextEditingController(text: AppFunction.getDayYYYYMMDD(pet.birthDay));
    weightEditingController =
        TextEditingController(text: pet.weight.toString());
    nameEditingFocusNode = FocusNode();
    birthDayEditingFocusNode = FocusNode();
    weightEditingFocusNode = FocusNode();
    isPregnancy = pet.isPregnancy ?? false;
    isNeuter = pet.isNeuter ?? false;
    imagePath = pet.imageUrl;
  }

  void updatePet(PetModel oldPetModel) {
    // String oldPetKey =
    //     '${oldPetModel.name}-${UtilFunction.getDayYYYYMMDD(oldPetModel.birthDay)}-${oldPetModel.genderType.gender}';

    PetModel newPetModel = PetModel(
      name: nameEditingController.text,
      imageUrl: imagePath ?? '', // TODO
      birthDay: birthDay ?? oldPetModel.birthDay,
      genderType: genderType,
      weight: double.parse(weightEditingController.text),
      isNeuter: isNeuter,
      isPregnancy: isPregnancy,
    );
    petsController.updatePetModel(oldPetModel, newPetModel);

    Get.snackbar(
      '',
      '',
      duration: const Duration(seconds: 2),
      titleText: Text(
        AppString.completeTextTr.tr,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Responsive.width18,
        ),
      ),
      messageText: Text(
        AppString.updateMsgTr.tr,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: Responsive.width16,
        ),
      ),
    );
  }

  void deletePet(String petName) async {
    bool result = await Get.dialog(AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.exclamation),
          ),
          SizedBox(width: Responsive.width10),
          Text(AppString.coutionTr.tr,
              style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              AppString.yesTextTr.tr,
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
        SizedBox(width: Responsive.width10),
        ElevatedButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            AppString.noTextTr.tr,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
      content: Text.rich(
        TextSpan(
          text: '', // 코마  こま
          style: TextStyle(fontSize: Responsive.width17),
          children: [
            TextSpan(text: AppString.previousDeletePetMsg1Tr.tr),
            TextSpan(
              text: petName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                fontSize: Responsive.width18,
              ),
            ),
            TextSpan(text: '${AppString.previousDeletePetMsg2Tr.tr}\n\n'),
            TextSpan(text: AppString.previousDeletePetMsg3Tr.tr),
            TextSpan(
              text: petName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                fontSize: Responsive.width18,
              ),
            ),
            TextSpan(text: AppString.previousDeletePetMsg4Tr.tr),
          ],
        ),
      ),
    ));

    if (result) {
      Get.back();
      petsController.deletePet();
    }
  }
}
