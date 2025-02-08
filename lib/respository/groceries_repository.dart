import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:hive/hive.dart';

class GroceriesRepository {
  void savedGivenCountPerDay(int selectedMenus) async {
    var box = await Hive.openBox<int>("givenCountPerDayKey");
    box.put('givenCountPerDay', selectedMenus);
  }

  Future<int?> getGivenCountPerDay() async {
    var box = await Hive.openBox<int>("givenCountPerDayKey");
    return box.get('givenCountPerDay');
  }

  void savedSelectedMenus(List<int> selectedMenus) async {
    var box = await Hive.openBox<List<int>>("savedMenusKey");
    box.put('savedMenus', selectedMenus);
  }

  Future<List<int>> getSelectedMenus() async {
    var box = await Hive.openBox<List<int>>("savedMenusKey");
    return box.get('savedMenus') ?? [] as List<int>;
  }

  Future<void> saveGrocery(GroceriesModel groceriesModel) async {
    var box =
        await Hive.openBox<GroceriesModel>(AppConstant.groceriesModelModelBox);

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
    List<GroceriesModel> groceries = box.values.toList();
    groceries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return box.values.toList();
  }
}
