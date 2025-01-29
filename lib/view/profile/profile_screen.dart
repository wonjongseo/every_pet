import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/profile_controller.dart';
import 'package:every_pet/controllers/enroll_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';
import 'package:every_pet/view/enroll/widgets/gender_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return GetBuilder<PetsController>(builder: (petController) {
      PetModel pet = petController.pets![petController.petPageIndex];
      controller.loadPetInfo(pet);
      return GetBuilder<ProfileController>(builder: (controller) {
        return Center(
          child: SingleChildScrollView(
            controller: petController.scrollController,
            child: Column(
              children: [
                EnrollScreenBody(controller: controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Responsive.width10 * 12,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.redAccent,
                            ),
                        onPressed: () {
                          controller.updatePet(pet);
                        },
                        child: Text(
                          AppString.updateBtnTextTr.tr,
                          style: TextStyle(
                            fontSize: Responsive.width18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width10 * 12,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        onPressed: () => controller.deletePet(pet.name),
                        child: Text(
                          AppString.cancelBtnTextTr.tr,
                          style: TextStyle(
                            fontSize: Responsive.width18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.height20),
              ],
            ),
          ),
        );
      });
    });
  }
}
