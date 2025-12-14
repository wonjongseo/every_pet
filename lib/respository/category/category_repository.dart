import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:every_pet/respository/category/i_category_repository.dart';
import 'package:hive/hive.dart';

class CategoryRepository extends ICategoryRepository {
  @override
  Future<void> saveCategory(ProductCategoryModel categoryModel) async {
    var box = await Hive.openBox<ProductCategoryModel>(
        AppConstant.categoryModelModelBox);

    await box.put(categoryModel.id, categoryModel);
  }

  @override
  Future<void> deleteCategory(ProductCategoryModel categoryModel) async {
    var box = await Hive.openBox<ProductCategoryModel>(
        AppConstant.categoryModelModelBox);

    await box.delete(categoryModel.id);
  }

  @override
  Future<List<ProductCategoryModel>> getCategorys() async {
    var box = await Hive.openBox<ProductCategoryModel>(
        AppConstant.categoryModelModelBox);
    List<ProductCategoryModel> categories = box.values.toList();

    categories.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return categories;
  }
}
