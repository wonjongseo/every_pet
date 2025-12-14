import 'package:every_pet/models/expensive_model.dart';

abstract class IExpensiveRepository {
  Future<void> saveExpensive(ExpensiveModel expensiveModel);

  Future<void> deleteExpensive(ExpensiveModel expensiveModel);

  Future<List<ExpensiveModel>> getExpensives();
}
