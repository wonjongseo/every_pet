import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDetailTodoController extends GetxController {
  final selectedStamps = <StampModel>[].obs;

  TextEditingController memoController = TextEditingController();
  TodoController todoController = Get.find<TodoController>();
  final selectedProfileIndexs = <int>[].obs;

  final TodoModel? todo;

  EditDetailTodoController(this.todo);

  @override
  void onInit() {
    super.onInit();
    memoController.text = todo?.memo ?? '';

    selectedStamps.assignAll(todoController.getSavedStampIndex());
    selectedProfileIndexs.add(todoController.petsController.petPageIndex);
  }

  void onTapStamp(StampModel stamp) {
    if (selectedStamps.contains(stamp)) {
      selectedStamps.remove(stamp);
    } else {
      selectedStamps.add(stamp);
    }
  }

  void onTapPets(int index) {
    if (selectedProfileIndexs.contains(index)) {
      selectedProfileIndexs.remove(index);
    } else {
      selectedProfileIndexs.add(index);
    }
  }

  @override
  void onClose() {
    memoController.dispose();
    super.onClose();
  }
}
