import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
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
        ProductCategoryModel(name: '-'),
        ProductCategoryModel(name: '+'),
      ],
    );
  }

  Future<void> onTapAddCategoryBtn() async {
    TextEditingController textEditingController = TextEditingController();
    bool? result = await Get.dialog(
      AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomTextField(
                controller: textEditingController,
                hintText: AppString.categoryText.tr,
                maxLines: 1,
              ),
            ),
            SizedBox(width: Responsive.width10),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              child: Text(AppString.enrollTextBtnTr.tr),
            )
          ],
        ),
      ),
    );
    if (result == null ||
        textEditingController.text == null ||
        textEditingController.text.isEmpty) {
      return;
    }

    ProductCategoryModel categoryModel =
        ProductCategoryModel(name: textEditingController.text);

    AppFunction.showMessageSnackBar(
        title: AppString.deleteBtnText.tr,
        message: '${categoryModel.name}　${AppString.doneAddtionMsg.tr}');

    saveCategory(categoryModel);
  }

  void deleteCategory(ProductCategoryModel category) {
    AppFunction.showMessageSnackBar(
        title: AppString.deleteBtnText.tr,
        message: '${category.name}　${AppString.doneDeletionMsg.tr}');
    categoryRepository.deleteCategory(category);
    getAllCategories();
  }

  void updateCategory(int index, String name) {
    ProductCategoryModel categoryModel = categories[index];

    if (categoryModel.name == name) {
      return;
    }
    categoryModel.name = name;
    AppFunction.showMessageSnackBar(
        title: AppString.doneUpdatedMsg.tr,
        message: '${categoryModel.name}　${AppString.doneAddtionMsg.tr}');
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
