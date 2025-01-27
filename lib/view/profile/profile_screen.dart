import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetsController>(builder: (controller) {
      PetModel pet = controller.pets![controller.petPageIndex];
      return Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(AppString.nameText.tr),
                Text(pet.name),
              ],
            ),
            Text(UtilFunction.getDayYYYYMMDD(pet.birthDay)),
            Text(pet.genderType.gender),
            Text(pet.isNeuter ?? false ? 'True' : 'False'),
            Text('${pet.weight}'),
            ElevatedButton(
              onPressed: controller.deletePet,
              child: Text('削除'),
            )
          ],
        ),
      );
    });
  }
}
