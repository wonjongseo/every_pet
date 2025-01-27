import 'package:every_pet/common/utilities/app_color.dart';
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
        TextEditingController(text: UtilFunction.getDayYYYYMMDD(pet.birthDay));
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
        '完了',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          // color: AppColors.blueDark,
          fontSize: Responsive.width18,
        ),
      ),
      messageText: Text(
        '更新されました。',
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
          const Text('注意', style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              'はい',
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
        SizedBox(width: Responsive.width10),
        ElevatedButton(
          onPressed: () => Get.back(result: false),
          child: const Text(
            'いいえ',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
      content: Text.rich(
        TextSpan(
          text: '',
          style: TextStyle(fontSize: Responsive.width17),
          children: [
            const TextSpan(text: '削除すると'),
            TextSpan(
              text: petName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.blueLight,
                fontSize: Responsive.width18,
              ),
            ),
            const TextSpan(text: 'に関するデータを戻すことができません。\n\n'),
            const TextSpan(text: 'それでも'),
            TextSpan(
              text: petName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.blueLight,
                fontSize: Responsive.width18,
              ),
            ),
            const TextSpan(text: 'を削除しますか？'),
          ],
        ),
      ),
    ));

    if (result) {
      petsController.deletePet();
    }
  }
}
