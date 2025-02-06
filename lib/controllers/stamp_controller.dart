import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/respository/stamp_repository.dart';
import 'package:every_pet/view/stamp_custom/stamp_custom_screen.dart';
import 'package:get/get.dart';

class StampController extends GetxController {
  StampRepository stampRepository = StampRepository();

  List<StampModel> stamps = [];

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

    AppFunction.showMessageSnackBar(
      title: AppString.deleteBtnText.tr,
      message: '${stamp.name}${AppString.doneDeletionMsg.tr}',
    );
    getAllStamps();
  }

  void saveStamp(StampModel stamp) {
    stampRepository.saveStamp(stamp);
    getAllStamps();
  }

  @override
  void onInit() async {
    await getAllStamps();
    super.onInit();
  }

  void onTapBackBtn() {
    Get.back();
    return;
  }

  void toggleVisable(int index) {
    StampModel selectedStamp = stamps[index];
    selectedStamp.isVisible = !selectedStamp.isVisible;
    saveStamp(selectedStamp);

    AppFunction.showMessageSnackBar(
      title: AppString.updateBtnText.tr,
      message:
          '${selectedStamp.name} ${selectedStamp.isVisible ? AppString.changedVisiableMsg.tr : AppString.changedInVisiableMsg.tr}',
      duration: const Duration(milliseconds: 1000),
    );

    update();
  }

  Future<void> getAllStamps() async {
    stamps = await stampRepository.getStamps();
    print('stamps.length : ${stamps.length}');

    update();
  }
}
