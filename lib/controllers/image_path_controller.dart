import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ImagePathController extends GetxController {
  late Directory directory;
  late String path;

  @override
  void onInit() async {
    try {
      directory = Platform.isIOS || Platform.isMacOS
          ? await getLibraryDirectory()
          : await getApplicationSupportDirectory();
      path = directory.path;
    } catch (e) {
      print('e.toString() : ${e.toString()}');
    }
    super.onInit();
  }
}
