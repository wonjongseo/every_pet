import 'package:every_pet/common/admob/interstitial_manager.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/snackbar_helper.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:every_pet/respository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  CategoryRepository categoryRepository = CategoryRepository();

  final RxList<ProductCategoryModel> categories = <ProductCategoryModel>[].obs;

  RxInt totalPrice = RxInt(0);
  RxMap categoryAndPrice = RxMap({});

  @override
  void onReady() {
    getAllCategories();
    super.onReady();
  }

  void getAllCategories() async {
    categories.assignAll(
      [
        ...await categoryRepository.getCategorys(),
        ProductCategoryModel(name: AppConstant.editCategorySign),
      ],
    );
  }

  Future<void> onTapAddCategoryBtn() async {
    TextEditingController teController = TextEditingController();

    bool? resultValue = await AppFunction.singleTextEditDialog(
      dialogName: "onTapAddCategoryBtn",
      hintText: AppString.categoryText.tr,
      buttonLabel: AppString.enrollTextBtnTr.tr,
      teController: teController,
    );

    if (resultValue == null) {
      return;
    }
    ProductCategoryModel categoryModel =
        ProductCategoryModel(name: teController.text);

    SnackBarHelper.showSuccessSnackBar(
        '${categoryModel.name}　${AppString.doneAddtionMsg.tr}');

    saveCategory(categoryModel);
    InterstitialManager.instance.maybeShow();
  }

  void deleteCategory(ProductCategoryModel category) {
    SnackBarHelper.showSuccessSnackBar(
        '${category.name}　${AppString.doneDeletionMsg.tr}');
    categoryRepository.deleteCategory(category);
    getAllCategories();
  }

  void updateCategory(int index, String name) {
    ProductCategoryModel categoryModel = categories[index];

    if (categoryModel.name == name) {
      return;
    }
    categoryModel.name = name;
    SnackBarHelper.showSuccessSnackBar(
        '${categoryModel.name}　${AppString.doneAddtionMsg.tr}');
    saveCategory(categoryModel);
  }

  void saveCategory(ProductCategoryModel category) {
    categoryRepository.saveCategory(category);
    getAllCategories();
  }

  int getPricePerMonth() {
    return categoryAndPrice.values.fold<int>(
        0, (previousValue, element) => previousValue + element as int);
  }
}
