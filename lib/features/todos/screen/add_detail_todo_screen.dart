import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDetailTodoController extends GetxController {}

class EditDetailTodoScreen extends StatelessWidget {
  static String name = '/add-todo';
  const EditDetailTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('TODOs'),
            ],
          ),
        ),
      ),
    );
  }
}
