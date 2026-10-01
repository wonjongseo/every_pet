import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/groceries_modal.dart';
import 'package:every_pet/respository/groceries/i_groceries_repository.dart';
import 'package:hive/hive.dart';

class GroceriesRepository extends IGroceriesRepository {
  @override
  void savedGivenCountPerDay(int selectedMenus) async {
    var box = await Hive.openBox<int>("givenCountPerDayKey");
    box.put('givenCountPerDay', selectedMenus);
  }

  @override
  Future<int?> getGivenCountPerDay() async {
    var box = await Hive.openBox<int>("givenCountPerDayKey");
    return box.get('givenCountPerDay');
  }

  @override
  void savedSelectedMenus(List<int> selectedMenus) async {
    var box = await Hive.openBox<List<int>>("savedMenusKey");
    box.put('savedMenus', selectedMenus);
  }

  @override
  Future<List<int>> getSelectedMenus() async {
    var box = await Hive.openBox<List<int>>("savedMenusKey");
    return box.get('savedMenus') ?? [] as List<int>;
  }

  @override
  Future<void> saveGrocery(GroceriesModel groceriesModel) async {
    var box =
        await Hive.openBox<GroceriesModel>(AppConstant.groceriesModelModelBox);

    await box.put(groceriesModel.id, groceriesModel);

    print('GroceriesModel saved');
  }

  @override
  Future<void> deleteGrocery(GroceriesModel groceriesModel) async {
    var box =
        await Hive.openBox<GroceriesModel>(AppConstant.groceriesModelModelBox);

    await box.delete(groceriesModel.id);

    print('GroceriesModel delete ');
  }

  @override
  Future<List<GroceriesModel>> getGroceries() async {
    var box =
        await Hive.openBox<GroceriesModel>(AppConstant.groceriesModelModelBox);
    List<GroceriesModel> groceries = box.values.toList();
    for (final grocery in groceries) {
      final normalizedName = AppString.normalizeDefaultNameKey(grocery.name);
      if (normalizedName != grocery.name) {
        grocery.name = normalizedName;
        await box.put(grocery.id, grocery);
      }
    }
    groceries.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return groceries;
  }
}
