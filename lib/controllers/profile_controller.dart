import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/respository/pet_repository.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
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
  }

  void updatePet(PetModel oldPetModel) {
    // String oldPetKey =
    //     '${oldPetModel.name}-${UtilFunction.getDayYYYYMMDD(oldPetModel.birthDay)}-${oldPetModel.genderType.gender}';

    PetModel newPetModel = PetModel(
      name: nameEditingController.text,
      imageUrl: '', // TODO
      birthDay: birthDay ?? oldPetModel.birthDay,
      genderType: genderType,
      weight: double.parse(weightEditingController.text),
      isNeuter: isNeuter,
      isPregnancy: isPregnancy,
    );
    petsController.updatePetModel(oldPetModel, newPetModel);
  }
}
