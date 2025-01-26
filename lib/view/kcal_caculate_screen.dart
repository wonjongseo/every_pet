import 'dart:io';

import 'package:every_pet/common/widgets/profile_image.dart';
import 'package:every_pet/controllers/pets_controller.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:every_pet/view/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KcalCaculateScreen extends StatefulWidget {
  const KcalCaculateScreen({super.key});

  @override
  State<KcalCaculateScreen> createState() => _KcalCaculateScreenState();
}

class _KcalCaculateScreenState extends State<KcalCaculateScreen> {
  PetsController petsController = Get.find<PetsController>();
  List<Map<String, dynamic>> kcals = [
    {'food': 'お米', 'kcal': 100, 'g': 100},
    {'food': 'じゃないも', 'kcal': 211, 'g': 100},
    {'food': 'たら', 'kcal': 143, 'g': 100},
    {'food': 'にんじん', 'kcal': 121, 'g': 100},
    {'food': 'ささみ', 'kcal': 147, 'g': 100},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('カロリー計算'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                children: List.generate(
                  petsController.pets!.length,
                  (index) {
                    PetModel pet = petsController.pets![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ProfileImage(
                            height: 50,
                            width: 50,
                            file:
                                pet.imageUrl != '' ? File(pet.imageUrl) : null,
                          ),
                          Text(pet.name)
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'RER: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${petsController.pets![0].getRER()}kcal',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.help,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'DER: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '${petsController.pets![0].getDER()}kcal',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.help,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
