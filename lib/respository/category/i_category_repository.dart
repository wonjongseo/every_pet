import 'package:every_pet/models/product_category_model.dart';

abstract class ICategoryRepository {
  Future<void> saveCategory(ProductCategoryModel categoryModel);

  Future<void> deleteCategory(ProductCategoryModel categoryModel);

  Future<List<ProductCategoryModel>> getCategorys();
}
