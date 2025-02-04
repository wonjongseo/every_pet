import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:hive/hive.dart';

class CategoryRepository {
  Future<void> saveCategory(ProductCategoryModel categoryModel) async {
    var box = await Hive.openBox<ProductCategoryModel>(
        AppConstant.categoryModelModelBox);

    await box.put(categoryModel.id, categoryModel);
    print('categoryModel : ${categoryModel}');

    print('CategoryModel saved');
  }

  Future<void> deleteCategory(ProductCategoryModel categoryModel) async {
    var box = await Hive.openBox<ProductCategoryModel>(
        AppConstant.categoryModelModelBox);

    await box.delete(categoryModel.id);

    print('CategoryModel delete ');
  }

  Future<List<ProductCategoryModel>> getCategorys() async {
    var box = await Hive.openBox<ProductCategoryModel>(
        AppConstant.categoryModelModelBox);
    print('box.values.length : ${box.values.length}');
    List<ProductCategoryModel> categories = box.values.toList();

    categories.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return categories;
  }
}
