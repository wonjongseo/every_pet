import 'dart:io';

import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/welcome_controller.dart';
import 'package:every_pet/models/dog_model.dart';
import 'package:every_pet/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> kcals = [
    {'food': 'お米', 'kcal': 100, 'g': 100},
    {'food': 'じゃないも', 'kcal': 211, 'g': 100},
    {'food': 'たら', 'kcal': 143, 'g': 100},
    {'food': 'にんじん', 'kcal': 121, 'g': 100},
    {'food': 'ささみ', 'kcal': 147, 'g': 100},
  ];
  WelcomeController controller = Get.put(WelcomeController());
  List<DogModel> dogs = [];

  @override
  void initState() {
    super.initState();
    getAllDogs();
  }

  getAllDogs() async {
    dogs = await controller.petRepository.loadDogs();
    setState(() {});
    print('dogs : ${dogs}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: dogs.isEmpty
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                      children: List.generate(dogs.length, (index) {
                    print('dogs[index] : ${dogs[index]}');

                    return Column(
                      children: [
                        Container(
                          height: 220,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              // color: context.theme.greyColor!.withOpacity(.4),
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: dogs[index].imageUrl.isEmpty
                                  ? const AssetImage(
                                      'assets/images/cute_dog.jpg')
                                  : FileImage(File(dogs[index].imageUrl!))
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(dogs[index].name),
                        Text(UtilFunction.getDayYYYYMMDD(dogs[index].birthDay)),
                        Text('RER : ${dogs[index].getRER().toString()}kcal'),
                        Text('DER : ${dogs[index].getDER().toString()}kcal'),

                        DropdownButton(
                          value: kcals[index]['food'],
                          items: List.generate(kcals.length, (index) {
                            return DropdownMenuItem(
                              value: kcals[index]['food'],
                              child: Text(kcals[index]['food']),
                            );
                          }),
                          onChanged: (v) {},
                          hint: Text("選択してください"),
                        )
                        // Divider(),
                        // Column(
                        //   children: [
                        //     Text('食材とカロリーを入力してください。'),
                        //     Row(
                        //       children: [
                        //         Text('食材'),
                        //         Expanded(
                        //           child: CustomTextField(),
                        //         )
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         Text('カロリー'),
                        //         Expanded(
                        //           child: CustomTextField(
                        //             hintText: '10gにつき、カロリーを入力してください',
                        //           ),
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // )
                      ],
                    );
                  })),
                ),
        ),
      ),
    );
  }
}
