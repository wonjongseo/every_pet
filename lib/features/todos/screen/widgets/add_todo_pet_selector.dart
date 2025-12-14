import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/features/todos/controller/edit_detail_todo_controller.dart';
import 'package:every_pet/view/main/widgets/row_pet_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTodoPetSelector extends GetView<EditDetailTodoController> {
  const AddTodoPetSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          controller.todoController.petsController.pets.length,
          (index) {
            return Padding(
              padding: EdgeInsets.only(right: Responsive.width22),
              child: Obx(
                () => RowPetProfileWidget(
                  imageWidth: 40,
                  petModel: controller.todoController.petsController
                      .getPetOfIndex(index),
                  isActive: controller.selectedProfileIndexs.contains(index),
                  onTap: () {
                    controller.onTapPets(index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
