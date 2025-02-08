import 'dart:async';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/add_button.dart';
import 'package:every_pet/controllers/category_controller.dart';
import 'package:every_pet/controllers/expensive_controller.dart';
import 'package:every_pet/view/expensive/change_category_screen.dart';
import 'package:flutter/material.dart';

import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ExpensiveInputCard extends StatefulWidget {
  const ExpensiveInputCard({
    super.key,
    this.selectedCategory,
    this.productName,
    this.itemPrice,
    this.streamController,
  });

  final String? selectedCategory;
  final String? productName;
  final String? itemPrice;
  final StreamController? streamController;

  @override
  State<ExpensiveInputCard> createState() => _ExpensiveInputCardState();
}

class _ExpensiveInputCardState extends State<ExpensiveInputCard> {
  String selectedCategory = '';

  bool isReadOnly = false;
  TextEditingController productNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  CategoryController categoryController = Get.put(CategoryController());
  ExpensiveController expensiveController = Get.find<ExpensiveController>();

  @override
  void initState() {
    if (widget.selectedCategory != null &&
        widget.productName != null &&
        widget.itemPrice != null) {
      isReadOnly = true;
      selectedCategory = widget.selectedCategory!;
      productNameController.text = widget.productName!;
      itemPriceController.text = widget.itemPrice!;
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    itemPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Obx(() {
              return CustomTextField(
                hintText: selectedCategory == ''
                    ? AppString.categoryText.tr
                    : selectedCategory,
                readOnly: true,
                hintStyle: isReadOnly ? contentStyle : null,
                style: isReadOnly ? contentStyle : null,
                // hintStyle: isReadOnly ? activeHintStyle : null,
                widget: DropdownButton<String>(
                  iconSize: 32,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: subTitleStyle,
                  onChanged: isReadOnly
                      ? null
                      : (v) async {
                          if (v! == AppConstant.editCategorySign) {
                            Get.to(() => const ChangeCategoryScreen());
                            return;
                          }
                          selectedCategory = v!;
                          setState(() {});
                        },
                  items: List.generate(
                    categoryController.categories.length,
                    (index) {
                      if (categoryController.categories[index].name ==
                          AppConstant.editCategorySign) {
                        return DropdownMenuItem(
                          value: categoryController.categories[index].name,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: Colors.grey[200]!, width: 1.5),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppString.changeCategoryText.tr),
                                SizedBox(width: Responsive.width10),
                                const FaIcon(FontAwesomeIcons.pencil),
                              ],
                            ),
                          ),
                        );
                      }
                      return DropdownMenuItem(
                        value: categoryController.categories[index].name,
                        child: Text(categoryController.categories[index].name),
                      );
                    },
                  ),
                ),
              );
            }),
            SizedBox(height: Responsive.height10),
            CustomTextField(
              readOnly: isReadOnly,
              style: isReadOnly ? activeHintStyle : null,
              hintText: AppString.productName.tr,
              controller: productNameController,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: Responsive.height10),
            CustomTextField(
              readOnly: isReadOnly,
              hintText: AppString.priceText.tr,
              style: isReadOnly ? activeHintStyle : null,
              keyboardType: TextInputType.number,
              controller: itemPriceController,
              prefixIcon: Text('${AppString.moneySign.tr} '),
            ),
          ],
        ),
        if (!isReadOnly) ...[
          SizedBox(height: Responsive.height10),
          Align(
            alignment: Alignment.centerRight,
            child: AddOrRemoveButton(
              onTap: () {
                if (selectedCategory == '') {
                  AppFunction.showInvalidTextFieldSnackBar(
                      message: AppString.categoryCtrAlertMsg.tr);
                  return;
                }

                if (productNameController.text == '') {
                  AppFunction.showInvalidTextFieldSnackBar(
                      message: AppString.productNameCtrAlertMsg.tr);
                  return;
                }

                if (itemPriceController.text == '') {
                  AppFunction.showInvalidTextFieldSnackBar(
                      message: AppString.priceCtrAlertMsg.tr);
                  return;
                }

                widget.streamController!.sink.add({
                  'selectedCategory': selectedCategory,
                  'productName': productNameController.text,
                  'price': itemPriceController.text
                });
                selectedCategory = '';
                productNameController.text = '';
                itemPriceController.text = '';
                FocusManager.instance.primaryFocus?.unfocus();
              },
              addOrRemove: AddOrRemoveType.ADD,
            ),
          ),
          SizedBox(height: Responsive.height20),
        ],
      ],
    );
  }
}
