import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:hive/hive.dart';

class StampRepository {
  Future<void> saveStamp(StampModel stamp) async {
    var box = await Hive.openBox<StampModel>(AppConstant.stampModelBox);

    // 데이터 저장
    // await box.add(todo);
    await box.put(stamp.iconIndex, stamp);

    print('Stamp saved!');
  }

//TODO key를 iconInded로 하는게 좋을까 ?
  Future<void> saveStampByNameAndIndex(StampModel stamp) async {
    var box = await Hive.openBox<StampModel>(AppConstant.stampModelBox);

    // 데이터 저장
    // await box.add(todo);
    await box.put(stamp.id, stamp);

    print('Stamp saved!');
  }

  Future<List<StampModel>> getStamps() async {
    var box = await Hive.openBox<StampModel>(AppConstant.stampModelBox);

    // 데이터 읽기
    List<StampModel> stamps = box.values.toList();
    stamps.sort((a, b) => a.iconIndex.compareTo(b.iconIndex));

    return stamps;
  }
}
