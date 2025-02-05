import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/category_controller.dart';
import 'package:every_pet/models/expensive_model.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:every_pet/respository/category_repository.dart';
import 'package:every_pet/respository/expensive_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensiveController extends GetxController {
  ExpensiveRepository expensiveRepository = ExpensiveRepository();

  // CategoryRepository categoryRepository = CategoryRepository();

  RxInt totalPrice = RxInt(0);
  RxMap categoryAndPrice = RxMap({});

  // final RxList<ProductCategoryModel> categories = <ProductCategoryModel>[].obs;
  final RxList<ExpensiveModel> _expensives = <ExpensiveModel>[].obs;

  RxList<ExpensiveModel> expensivesByDay(DateTime date) {
    return _expensives.where((p0) => p0.date == date).toList().obs;
  }

  RxList<ExpensiveModel> expensivesByMonth(int month) {
    return _expensives.where((p0) => p0.date.month == month).toList().obs;
  }

  @override
  void onReady() {
    getAllExpensive();
    super.onReady();
  }

  void calculateTotalPricePerMonth(int month) {
    categoryAndPrice = RxMap({});
    var expensivesOfMonth = expensivesByMonth(month);

    for (var element in expensivesOfMonth) {
      if (!categoryAndPrice.containsKey(element.category)) {
        categoryAndPrice[element.category] = element.price;
      } else {
        categoryAndPrice[element.category] += element.price;
      }
    }
  }

  int getPricePerMonth() {
    return categoryAndPrice.values.fold<int>(
        0, (previousValue, element) => previousValue + element as int);
  }

  void saveExpensive(ExpensiveModel expensive) {
    expensiveRepository.saveExpensive(expensive);
    getAllExpensive();
  }

  void getAllExpensive() async {
    _expensives.assignAll(await expensiveRepository.getExpensives());
  }

  void delete(ExpensiveModel expensive) {
    expensiveRepository.deleteExpensive(expensive);
    getAllExpensive();
  }
}
