import 'package:every_pet/controllers/image_path_controller.dart';
import 'package:every_pet/controllers/main_controller.dart';

import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImagePathController());
    // Get.put(MainController(), permanent: true);
  }
}
