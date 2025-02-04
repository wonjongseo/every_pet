import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/models/nutrition_model.dart';
import 'package:every_pet/models/product_category_model.dart';
import 'package:hive/hive.dart';

class GroceriesRepository {
  Future<void> saveGrocery(GroceriesModel groceriesModel) async {
    var box =
        await Hive.openBox<GroceriesModel>(AppConstant.groceriesModelModelBox);

    print('groceriesModel : ${groceriesModel}');

    await box.put(groceriesModel.id, groceriesModel);

    print('GroceriesModel saved');
  }

  Future<void> deleteGrocery(GroceriesModel groceriesModel) async {
    var box =
        await Hive.openBox<GroceriesModel>(AppConstant.groceriesModelModelBox);

    await box.delete(groceriesModel.id);

    print('GroceriesModel delete ');
  }

  Future<List<GroceriesModel>> getGroceries() async {
    var box =
        await Hive.openBox<GroceriesModel>(AppConstant.groceriesModelModelBox);
    print('GroceriesModel.length : ${box.values.length}');
    List<GroceriesModel> groceries = box.values.toList();
    groceries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return box.values.toList();
  }
}
