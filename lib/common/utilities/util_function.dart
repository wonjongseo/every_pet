import 'dart:typed_data';
import 'dart:io';
import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:every_pet/common/extension/custom_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AppFunction {
  static String getDayYYYYMMDD(DateTime date) {
    return DateFormat(
            'yyyy${AppString.yearText.tr}M${AppString.monthText.tr}d${AppString.dayTextTr.tr}')
        .format(date);
  }

  static Future<File> uint8ListToFile(Uint8List data) async {
    // 앱의 임시 디렉토리 경로 가져오기
    final tempDir = await getTemporaryDirectory();

    // 파일의 전체 경로 생성
    final filePath =
        join(tempDir.path, '${DateTime.now().microsecondsSinceEpoch}.png');

    // Uint8List 데이터를 파일로 저장
    File file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
    await file.writeAsBytes(data);

    return file;
  }

  static Future<String> saveFileFromTempDirectory(
      String tempFileImage, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();

    final docFile = File('${directory.path}/$fileName.png');
    File tempFile = File(tempFileImage);
    await tempFile.copy(docFile.path);

    await tempFile.delete();

    return docFile.path;
  }

  static showInvalidTextFieldSnackBar(
      {required String title, required String message}) {
    AppFunction.showSnackBar(title, message, Icons.warning_amber_rounded);
  }

  static showSnackBar(String title, String message, IconData icon) {
    if (Get.isSnackbarOpen) return;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[200],
      colorText: pinkClr,
      icon: Icon(
        icon,
        color: pinkClr,
      ),
    );
  }

  static showAlertDialog({
    required BuildContext context,
    required String message,
    String? btnText,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          content: Text(
            message,
            style: TextStyle(color: context.exTheme.greyColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                btnText ?? "OK",
                style: TextStyle(
                  color: context.exTheme.circleImageColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
