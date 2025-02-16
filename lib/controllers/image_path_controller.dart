import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ImagePathController extends GetxController {
  late Directory directory;
  late String path;

  @override
  void onInit() async {
    directory = await getLibraryDirectory();
    path = directory.path;
    super.onInit();
  }
}
