import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/features/todos/controller/edit_detail_todo_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/view/todo/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditStampSelector extends GetView<EditDetailTodoController> {
  const EditStampSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        alignment: WrapAlignment.center,
        spacing: 30,
        runSpacing: 20,
        children: List.generate(
          StampController.to.stamps
              .where((element) => element.isVisible)
              .length,
          (index) {
            StampModel stampModel = StampController.to.stamps[index];
            return ColIconButton(
              icon: StampModel.getIcon(stampModel.iconIndex),
              label: stampModel.name,
              onTap: () {
                controller.onTapStamp(stampModel);
              },
              isActive: controller.selectedStamps
                  .contains(StampController.to.stamps[index]),
            );
          },
        ),
      ),
    );
    return GridView.builder(
      itemCount: StampController.to.stamps
          .where((element) => element.isVisible)
          .length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 85,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        return Obx(
          () {
            StampModel stampModel = StampController.to.stamps[index];
            return ColIconButton(
              icon: StampModel.getIcon(stampModel.iconIndex),
              label: stampModel.name,
              onTap: () {
                controller.onTapStamp(stampModel);
              },
              isActive: controller.selectedStamps
                  .contains(StampController.to.stamps[index]),
            );
          },
        );
      },
    );
    return GridView.builder(
      itemCount: StampController.to.stamps
          .where((element) => element.isVisible)
          .length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 85,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        return Obx(
          () {
            StampModel stampModel = StampController.to.stamps[index];
            return ColIconButton(
              icon: StampModel.getIcon(stampModel.iconIndex),
              label: stampModel.name,
              onTap: () {
                controller.onTapStamp(stampModel);
              },
              isActive: controller.selectedStamps
                  .contains(StampController.to.stamps[index]),
            );
          },
        );
      },
    );
  }
}
