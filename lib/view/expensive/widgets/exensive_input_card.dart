import 'dart:async';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/snackbar_helper.dart';
import 'package:every_pet/controllers/category_controller.dart';
import 'package:every_pet/controllers/expensive_controller.dart';
import 'package:every_pet/view/expensive/change_category_screen.dart';
import 'package:every_pet/view/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
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
  final GlobalKey<PopupMenuButtonState<String>> _categoryMenuKey =
      GlobalKey<PopupMenuButtonState<String>>();
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
      selectedCategory = AppString.normalizeDefaultNameKey(
        widget.selectedCategory!,
      );
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
    final inputContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(AppString.categoryText.tr),
        Obx(() {
          final categories = categoryController.categories.toList();
          return _categoryField(categories);
        }),
        SizedBox(height: Responsive.height14),
        _fieldLabel(AppString.productName.tr),
        CustomTextField(
          readOnly: isReadOnly,
          style: isReadOnly ? activeHintStyle : null,
          hintText: AppString.productName.tr,
          controller: productNameController,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: Responsive.height14),
        _fieldLabel(AppString.priceText.tr),
        CustomTextField(
          readOnly: isReadOnly,
          hintText: AppString.priceText.tr,
          style: isReadOnly ? activeHintStyle : null,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: itemPriceController,
          prefixIcon: Text('${AppString.moneySign.tr} '),
        ),
      ],
    );

    if (isReadOnly) {
      return Container(
        padding: EdgeInsets.all(Responsive.width14),
        decoration: BoxDecoration(
          color: SettingController.to.blackOrWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(.45)),
        ),
        child: inputContent,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.width14),
          decoration: BoxDecoration(
            color: SettingController.to.blackOrWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryColor.withOpacity(.35)),
          ),
          child: inputContent,
        ),
        SizedBox(height: Responsive.height14),
        SizedBox(
          height: Responsive.height10 * 5.2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _submit,
            child: Text(
              AppString.saveText.tr,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Responsive.width15,
              ),
            ),
          ),
        ),
        SizedBox(height: Responsive.height20),
      ],
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(
        left: Responsive.width10 / 2,
        bottom: Responsive.height10 / 2,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: Responsive.width14 * .9,
          fontWeight: FontWeight.w600,
          color: SettingController.to.realBlackOrWhite.withOpacity(.75),
        ),
      ),
    );
  }

  Widget _categoryField(List<dynamic> categories) {
    return CustomTextField(
      hintText: selectedCategory == ''
          ? AppString.categoryText.tr
          : AppString.displayName(selectedCategory),
      readOnly: true,
      hintStyle: isReadOnly ? contentStyle : null,
      style: isReadOnly ? contentStyle : null,
      onTap: isReadOnly
          ? null
          : () => _categoryMenuKey.currentState?.showButtonMenu(),
      sufficIcon: isReadOnly
          ? null
          : PopupMenuButton<String>(
              key: _categoryMenuKey,
              initialValue: selectedCategory.isEmpty ? null : selectedCategory,
              onSelected: _selectCategory,
              itemBuilder: (_) => _categoryMenuItems(categories),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
    );
  }

  List<PopupMenuEntry<String>> _categoryMenuItems(
    List<dynamic> categories,
  ) {
    return List.generate(
      categories.length,
      (index) {
        final category = categories[index];
        if (category.name == AppConstant.editCategorySign) {
          return PopupMenuItem(
            value: category.name,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppString.changeCategoryText.tr),
                ],
              ),
            ),
          );
        }
        return PopupMenuItem(
          value: category.name,
          child: Text(category.displayName),
        );
      },
    );
  }

  void _selectCategory(String value) {
    if (value == AppConstant.editCategorySign) {
      Get.toNamed(ChangeCategoryScreen.name);
      return;
    }
    selectedCategory = value;
    setState(() {});
  }

  void _submit() {
    if (selectedCategory == '') {
      SnackBarHelper.showErrorSnackBar(AppString.categoryCtrAlertMsg.tr);
      return;
    }

    if (productNameController.text == '') {
      SnackBarHelper.showErrorSnackBar(AppString.productNameCtrAlertMsg.tr);
      return;
    }

    if (itemPriceController.text == '') {
      SnackBarHelper.showErrorSnackBar(AppString.priceCtrAlertMsg.tr);
      return;
    }

    widget.streamController!.sink.add({
      'selectedCategory': selectedCategory,
      'productName': productNameController.text,
      'price': itemPriceController.text,
    });
    selectedCategory = '';
    productNameController.text = '';
    itemPriceController.text = '';
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {});
  }
}
