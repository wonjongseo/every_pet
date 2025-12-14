import 'package:every_pet/models/groceries_modal.dart';
import 'package:hive/hive.dart';

abstract class IGroceriesRepository {
  void savedGivenCountPerDay(int selectedMenus);
  Future<int?> getGivenCountPerDay() async {
    var box = await Hive.openBox<int>("givenCountPerDayKey");
    return box.get('givenCountPerDay');
  }

  void savedSelectedMenus(List<int> selectedMenus);
  Future<List<int>> getSelectedMenus();

  Future<void> saveGrocery(GroceriesModel groceriesModel);

  Future<void> deleteGrocery(GroceriesModel groceriesModel);

  Future<List<GroceriesModel>> getGroceries();
}
