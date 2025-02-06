import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:hive/hive.dart';

class StampRepository {
  Future<void> saveStamp(StampModel stamp) async {
    var box = await Hive.openBox<StampModel>(AppConstant.stampModelBox);

    await box.put(stamp.id, stamp);

    print('Stamp saved!');
  }

  Future<List<StampModel>> getStamps() async {
    var box = await Hive.openBox<StampModel>(AppConstant.stampModelBox);

    List<StampModel> stamps = box.values.toList();

    stamps.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return stamps;
  }

  void deleteStamp(StampModel stampModel) async {
    var box = await Hive.openBox<StampModel>(AppConstant.stampModelBox);
    await box.delete(stampModel.id);
  }
}
