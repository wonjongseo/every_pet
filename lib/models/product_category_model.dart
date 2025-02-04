import 'package:hive/hive.dart';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:uuid/uuid.dart';
part 'product_category_model.g.dart';

@HiveType(typeId: AppConstant.categoryModelHiveId)
class ProductCategoryModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  late String id;
  @HiveField(2)
  late DateTime createdAt;

  ProductCategoryModel({required this.name}) {
    id = const Uuid().v4();
    createdAt = DateTime.now();
  }

  @override
  String toString() =>
      'CategoryModel(name: $name, id: $id, createdAt: $createdAt)';
}
