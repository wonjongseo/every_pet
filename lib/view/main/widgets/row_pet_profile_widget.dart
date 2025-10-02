import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/full_profile_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowPetProfileWidget extends StatelessWidget {
  const RowPetProfileWidget({
    Key? key,
    required this.petModel,
    this.imageWidth,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final PetModel petModel;
  final double? imageWidth;
  final bool isActive;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(
          onTap: onTap,
          onLongPress: () => Get.to(
            () => FullProfileImageScreen(imagePath: petModel.profilePath),
          ),
          imagePath: petModel.profilePath,
          width: imageWidth ?? 40,
          height: imageWidth ?? 40,
          isActive: isActive,
          genderType: petModel.genderType,
        ),
        Text(
          petModel.name,
          style: isActive
              ? const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                )
              : TextStyle(fontSize: 11, color: Colors.grey.withOpacity(.7)),
        ),
      ],
    );
  }
}
