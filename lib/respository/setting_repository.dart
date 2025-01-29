import 'package:hive/hive.dart';

class SettingKey {
  static const String lastPetIndex = 'lastPetIndex';
  static const String lastBottomTapIndex = 'lastBottomTapIndex';
  static const String lastNutritionBottomPageIndex =
      'lastNutritionBottomPageIndex';
}

class SettingRepository {
  static Future<void> setString(String key, String value) async {
    var box = await Hive.openBox('settings');

    await box.put(key, value);
  }

  static Future<String> getString(String key) async {
    var box = await Hive.openBox('settings');

    return box.get(key, defaultValue: '');
  }

  static Future<void> setInt(String key, int value) async {
    var box = await Hive.openBox('settings');

    await box.put(key, value);
  }

  static Future<int> getInt(String key) async {
    var box = await Hive.openBox('settings');

    return box.get(key, defaultValue: 0);
  }
}
