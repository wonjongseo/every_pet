import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/expensive_model.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:hive/hive.dart';

class ExpensiveRepository {
  Future<void> saveExpensive(ExpensiveModel expensiveModel) async {
    var box =
        await Hive.openBox<ExpensiveModel>(AppConstant.expensiveModelModelBox);

    await box.put(expensiveModel.id, expensiveModel);

    print('expensiveModel saved');
  }

  Future<void> deleteExpensive(ExpensiveModel expensiveModel) async {
    var box =
        await Hive.openBox<ExpensiveModel>(AppConstant.expensiveModelModelBox);

    await box.delete(expensiveModel.id);

    print('delete saved');
  }

  Future<List<ExpensiveModel>> getExpensives() async {
    var box =
        await Hive.openBox<ExpensiveModel>(AppConstant.expensiveModelModelBox);
    print('box.values.length : ${box.values.length}');
    List<ExpensiveModel> expensiveModels = box.values.toList();

    expensiveModels.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return expensiveModels;
  }
}
