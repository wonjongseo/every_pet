import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/controllers/profile_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/enroll/enroll_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return GetBuilder<PetsController>(builder: (petController) {
      PetModel pet = petController.pets![petController.petPageIndex];
      controller.loadPetInfo(pet);
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GetBuilder<ProfileController>(builder: (controller) {
            return Center(
              child: SingleChildScrollView(
                controller: petController.scrollController,
                child: Column(
                  children: [
                    EnrollScreenBody(controller: controller),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          label: AppString.updateBtnText.tr,
                          onTap: () => controller.updatePet(pet),
                        ),
                        SizedBox(height: Responsive.height15),
                        CustomButton(
                          label: AppString.deleteBtnText.tr,
                          color: AppColors.secondaryColor,
                          onTap: () => controller.deletePet(pet.name),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.height20),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    // required this.pet,
    required this.onTap,
    this.height,
    this.color,
  }) : super(key: key);

  final String label;
  final double? height;
  // final PetModel pet;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height ?? Responsive.height10 * 5.2,
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.width20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color ?? AppColors.primaryColor,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: Responsive.width18,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
