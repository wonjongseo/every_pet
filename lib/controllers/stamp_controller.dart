import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/respository/stamp_repository.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:get/get.dart';

class StampController extends GetxController {
  StampRepository stampRepository = StampRepository();

  List<StampModel> stamps = [];

  updateStampList() {}

  void updateStamp(StampModel updateStamp) {
    stampRepository.saveStamp(updateStamp);
    for (var i = 0; i < stamps.length; i++) {
      if (stamps[i].id == updateStamp.id) {
        stamps[i] = updateStamp;
      }
    }
    update();
  }

  void deleteStamp(StampModel stamp) {
    stampRepository.deleteStamp(stamp);
    getAllStamps();
  }

  void saveStamp(StampModel stamp) {
    stampRepository.saveStamp(stamp);
    getAllStamps();
  }

  @override
  void onReady() {
    super.onReady();
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

    update();

    /*
      1日　１５０G = 519kcal

      １００G　３４６kcal

      1G = 3.46kcal
      １２０G　= 415.2kcal


      104kcal

     */
  }
}
