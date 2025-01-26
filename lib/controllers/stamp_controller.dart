import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/respository/stamp_repository.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:get/get.dart';

class StampController extends GetxController {
  StampRepository stampRepository = StampRepository();

  List<StampModel> stamps = [];
  List<StampModel> addstampsIcon = [
    StampModel(name: '', iconIndex: 8, isVisible: true),
    StampModel(name: '', iconIndex: 9, isVisible: true),
    StampModel(name: '', iconIndex: 10, isVisible: true),
  ];

  updateStampList() {}

  void goToStampCustomScreen() async {
    List<StampModel> result = await await Get.to(() => StampCustomScreen());

    stamps = result;

    update();
    for (var stamp in stamps) {
      print('stamp : ${stamp}');

      stampRepository.saveStamp(stamp);
    }
  }

  @override
  void onInit() {
    super.onInit();

    getAllStamps();
  }

  void onTapBackBtn() {
    Get.back();
    return;
  }

  void toogleVisualbe(int index) {
    stamps[index].isVisible = !stamps[index].isVisible;
    update();
  }

  getAllStamps() async {
    stamps = await stampRepository.getStamps();
    if (stamps.isEmpty) {
      List<StampModel> tempStamps = [
        StampModel(name: '薬１', iconIndex: 0, isVisible: true), // 0xFFff9796
        StampModel(name: '薬２', iconIndex: 1, isVisible: true), // 0xFF229cff
        StampModel(name: '病院', iconIndex: 2, isVisible: true), // 0xFF56e1ff
        StampModel(name: '入院', iconIndex: 3, isVisible: true), // 0xFFf59b23
        StampModel(name: '退院', iconIndex: 4, isVisible: true), // 0xFFf59b23
        StampModel(name: 'トリミング', iconIndex: 5, isVisible: true), // 0xFF7ec636
        StampModel(name: 'ドッグラン', iconIndex: 6, isVisible: true), // 0xFFe5b7ff
        StampModel(name: 'フィライア', iconIndex: 7, isVisible: true), // 0xFFdbff85
      ];

      for (var tempStamp in tempStamps) {
        await stampRepository.saveStamp(tempStamp);
      }
      stamps = await stampRepository.getStamps();
    }

    update();
  }
}
