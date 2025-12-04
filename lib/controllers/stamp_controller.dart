import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/snackbar_helper.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/respository/stamp_repository.dart';
import 'package:get/get.dart';

class StampController extends GetxController {
  StampRepository stampRepository = StampRepository();

  List<StampModel> stamps = [];

  void deleteStamp(StampModel stamp) {
    stampRepository.deleteStamp(stamp);

    SnackBarHelper.showErrorSnackBar(
      '${stamp.name}${AppString.doneDeletionMsg.tr}',
    );
    getAllStamps();
  }

  void putStamp(StampModel stamp) {
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
    putStamp(selectedStamp);

    SnackBarHelper.showSuccessSnackBar(
        '${selectedStamp.name} ${selectedStamp.isVisible ? AppString.changedVisiableMsg.tr : AppString.changedInVisiableMsg.tr}');

    update();
  }

  Future<void> getAllStamps() async {
    stamps = await stampRepository.getStamps();

    update();
  }
}
