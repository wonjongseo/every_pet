import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/features/todos/controller/edit_detail_todo_controller.dart';
import 'package:every_pet/features/todos/screen/widgets/add_todo_pet_selector.dart';
import 'package:every_pet/features/todos/screen/widgets/edit_stamp_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDetailTodoScreen extends GetView<EditDetailTodoController> {
  static String name = '/add_todo';
  const EditDetailTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label(AppString.selectPetText.tr),
                    SizedBox(height: Responsive.height10 * .8),
                    const AddTodoPetSelector(),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(height: Responsive.height10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(AppString.selectScheduleText.tr),
                  SizedBox(height: Responsive.height10 * 1.5),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    // height: (Responsive.width10 * 5) * 6.5,
                    child: const EditStampSelector(),
                  ),
                ],
              ),
              SizedBox(height: Responsive.height10 * 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(AppString.selectScheduleText.tr),
                  SizedBox(height: Responsive.height10 * 1.5),
                  Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _label(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor,
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }
}
