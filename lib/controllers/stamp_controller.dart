import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/respository/stamp_repository.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:get/get.dart';

class StampController extends GetxController {
  StampRepository stampRepository = StampRepository();

  List<StampModel> stamps = [];

  updateStampList() {}

  void goToStampCustomScreen() {
    Get.to(() => StampCustomScreen());
  }

  void updateStamp(StampModel updateStamp) {
    stampRepository.saveStamp(updateStamp);
    for (var i = 0; i < stamps.length; i++) {
      if (stamps[i].id == updateStamp.id) {
        stamps[i] = updateStamp;
      }
    }

    update();
  }

  void saveStamp(StampModel stamp) {
    stampRepository.saveStamp(stamp);
    stamps.add(stamp);
    update();
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
        StampModel(
          name: AppString.stamp1Tr.tr,
          iconIndex: 0,
          isVisible: true,
        ), // 0xFFff9796
        StampModel(
          name: AppString.stamp2Tr.tr,
          iconIndex: 1,
          isVisible: true,
        ), // 0xFF229cff
        StampModel(
          name: AppString.stamp3Tr.tr,
          iconIndex: 2,
          isVisible: true,
        ), // 0xFF56e1ff
        StampModel(
          name: AppString.stamp4Tr.tr,
          iconIndex: 3,
          isVisible: true,
        ), // 0xFFf59b23
        StampModel(
          name: AppString.stamp5Tr.tr,
          iconIndex: 4,
          isVisible: true,
        ), // 0xFFf59b23
        StampModel(
          name: AppString.stamp6Tr.tr,
          iconIndex: 5,
          isVisible: true,
        ), // 0xFF7ec636
        StampModel(
          name: AppString.stamp7Tr.tr,
          iconIndex: 6,
          isVisible: true,
        ), // 0xFFe5b7ff
        StampModel(
          name: AppString.stamp8Tr.tr,
          iconIndex: 7,
          isVisible: true,
        ), // 0xFFdbff85
      ];

      for (var tempStamp in tempStamps) {
        await stampRepository.saveStamp(tempStamp);
      }
      stamps = await stampRepository.getStamps();
    }

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
