import 'dart:developer';

import 'package:flutter/services.dart';

class NativeCaller {
  static String channelName = 'com.wonjongseo.every_pets/channel';

  static Future<void> callPhone(String number) async {
    var platform = MethodChannel(channelName);

    try {
      await platform.invokeMethod('callPhone', {'number': number});
    } on PlatformException catch (e) {
      log('native call method error : $e');
    }
  }
}
