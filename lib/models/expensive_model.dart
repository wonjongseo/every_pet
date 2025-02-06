import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'expensive_model.g.dart';

@HiveType(typeId: AppConstant.expensiveModelHiveId)
class ExpensiveModel {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final int price;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  late String id;
  @HiveField(5)
  late int createdAt;

  ExpensiveModel({
    required this.date,
    required this.category,
    required this.productName,
    required this.price,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() =>
      'ExpensiveModel(category: $category, productName: $productName, price: $price)';
}
