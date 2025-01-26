import 'dart:typed_data';
import 'dart:io';
import 'package:path/path.dart';
import 'package:every_pet/common/extension/custom_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class UtilFunction {
  static String getDayYYYYMMDD(DateTime date) {
    return DateFormat('yyyy年M月d日').format(date);
  }

  static Future<File> uint8ListToFile(Uint8List data) async {
    // 앱의 임시 디렉토리 경로 가져오기
    final tempDir = await getTemporaryDirectory();

    // 파일의 전체 경로 생성
    final filePath = join(tempDir.path, 'temp.png');

    // Uint8List 데이터를 파일로 저장
    File file = File(filePath);
    await file.writeAsBytes(data);

    return file;
  }

  static Future<File> saveFileFromTempDirectory(
      File tempFile, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();

    final docFile = File('${directory.path}/$fileName.png');

    await tempFile.copy(docFile.path);
    print('tempFile : ${tempFile}');

    print('directory : ${directory}');

    print('docFile : ${docFile}');

    await tempFile.delete();

    return docFile;
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
            style: TextStyle(color: context.theme.greyColor),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                btnText ?? "OK",
                style: TextStyle(
                  color: context.theme.circleImageColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
