import 'dart:io';

import 'package:every_pet/view/main/widgets/row_pet_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/controllers/pets_controller.dart';

class TopNaviBar extends GetView<PetsController> {
  const TopNaviBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width10),
      child: Row(
        children: [
          Obx(
            () {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      controller.pets.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: Responsive.width15)
                              .copyWith(top: Platform.isAndroid ? 10 : 0),
                          child: RowPetProfileWidget(
                            petModel: controller.getPetOfIndex(index)!,
                            isActive: controller.petPageIndex == index,
                            onTap: () => controller.onTapTopBar(index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          AddOrRemoveButton(
            onTap: controller.goToEnrollScreen,
            addOrRemove: AddOrRemoveType.ADD,
          ),
        ],
      ),
    );
  }
}
