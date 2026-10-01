import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/snackbar_helper.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/respository/stamp/stamp_repository.dart';
import 'package:get/get.dart';

class StampController extends GetxController {
  static StampController get to => Get.find<StampController>();
  StampRepository stampRepository = StampRepository();

  final stamps = <StampModel>[].obs;

  void deleteStamp(StampModel stamp) async {
    await stampRepository.deleteStamp(stamp);

    SnackBarHelper.showErrorSnackBar(
      '${stamp.displayName}${AppString.doneDeletionMsg.tr}',
    );
    await getAllStamps();
  }

  void putStamp(StampModel stamp) async {
    await stampRepository.saveStamp(stamp);
    await getAllStamps();
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
        '${selectedStamp.displayName} ${selectedStamp.isVisible ? AppString.changedVisiableMsg.tr : AppString.changedInVisiableMsg.tr}');

    update();
  }

  Future<void> getAllStamps() async {
    stamps.assignAll(await stampRepository.getStamps());
    update();
  }
}
