import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/respository/setting_repository.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';

class AppReviewController {
  static final InAppReview _inAppReview = InAppReview.instance;
  static final appUsageCountBox = Hive.box<int>('usageCount');
  static final isReviewedBox = Hive.box<bool>('hasReviewed');

  static Future<void> checkReviewRequest() async {
    await _inAppReview.isAvailable();

    int usageCount =
        await SettingRepository.getInt(AppConstant.countOfReiveRequestionKey);

    SettingRepository.setInt(
        AppConstant.countOfReiveRequestionKey, usageCount + 1);

    bool hasReviewed =
        await SettingRepository.getBool(AppConstant.hasReviewedKey);

    if (!hasReviewed) {
      // 등비수열 (10, 30, 60, 100, ...)
      if (_shouldRequestReview(usageCount)) {
        await _requestReview();
      }
    }
  }

  static bool _shouldRequestReview(int count) {
    int n = 1;
    while (true) {
      int geometricTerm = n * (n + 1) * 5;
      if (count == geometricTerm) {
        return true;
      } else if (count < geometricTerm) {
        return false;
      }
      n++;
    }
  }

  static Future<void> _requestReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
      await SettingRepository.setBool(AppConstant.hasReviewedKey, true);
    }
  }
}
