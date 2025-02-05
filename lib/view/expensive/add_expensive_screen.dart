import 'dart:async';

import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/controllers/expensive_controller.dart';
import 'package:every_pet/models/expensive_model.dart';
import 'package:every_pet/view/expensive/widgets/exensive_input_card.dart';
import 'package:flutter/material.dart';

import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:get/get.dart';

class AddExpensiveScreen extends StatefulWidget {
  const AddExpensiveScreen({super.key, required this.selectedDay});

  final DateTime selectedDay;
  @override
  State<AddExpensiveScreen> createState() => _AddExpensiveScreenState();
}

class _AddExpensiveScreenState extends State<AddExpensiveScreen> {
  ExpensiveController expensiveController = Get.find<ExpensiveController>();

  StreamController streamController = StreamController();

  @override
  void initState() {
    super.initState();
    streamController.stream.listen((event) {
      String selectedCategory = event['selectedCategory'];
      String productName = event['productName'];
      String price = event['price'];

      ExpensiveModel expensiveModel = ExpensiveModel(
        category: selectedCategory,
        productName: productName,
        price: int.parse(price),
        date: widget.selectedDay,
      );

      expensiveController.saveExpensive(expensiveModel);
      setState(() {}); // Dont' Remote
      AppFunction.showMessageSnackBar(
        title: AppString.saveText.tr,
        message: '${expensiveModel.productName}${AppString.doneAddtionMsg.tr}',
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void deleteExpensive(ExpensiveModel expensiveModel) async {
    expensiveController.delete(expensiveModel);

    AppFunction.showMessageSnackBar(
        title: AppString.deleteBtnText.tr,
        message:
            '${expensiveModel.productName}${AppString.doneDeletionMsg.tr}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: const GlobalBannerAdmob(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.height10 * .8,
              horizontal: Responsive.width10 * 2,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppFunction.getDayYYYYMMDD(widget.selectedDay),
                    style: headingStyle,
                  ),
                  SizedBox(height: Responsive.height10),
                  Column(
                    children: [
                      ExpensiveInputCard(streamController: streamController),
                    ],
                  ),
                  SizedBox(height: Responsive.height10),
                  Obx(
                    () {
                      var expensiveModels = expensiveController
                          .expensivesByDay(widget.selectedDay);
                      return Column(
                        children: List.generate(
                          expensiveModels.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(
                              bottom: Responsive.height10,
                            ),
                            child: Column(
                              children: [
                                ExpensiveInputCard(
                                  key: ValueKey(expensiveModels[index].id),
                                  selectedCategory:
                                      expensiveModels[index].category,
                                  productName:
                                      expensiveModels[index].productName,
                                  itemPrice:
                                      expensiveModels[index].price.toString(),
                                ),
                                SizedBox(height: Responsive.height10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: () {
                                      deleteExpensive(expensiveModels[index]);
                                    },
                                    child: Image.asset(
                                        AppImagePath.circleRemoteBtn,
                                        width: 40),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
