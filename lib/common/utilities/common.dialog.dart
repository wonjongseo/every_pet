import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialog {
  static Future<bool> jonggackDialog(
      {Widget? title, Widget? connent, Widget? action}) async {
    bool result = await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: Border.all(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              title,
              SizedBox(height: Responsive.height20),
            ],
            if (connent != null) ...[
              connent,
              SizedBox(height: Responsive.height20),
            ],
            const Align(alignment: Alignment.center, child: JonggackAvator()),
            if (action != null) ...[
              SizedBox(height: Responsive.height20),
              action,
              SizedBox(height: Responsive.height10),
            ],
          ],
        ),
      ),
    );

    return result;
  }

  static Future<bool> changeSystemLanguage() async {
    return selectionDialog(
      title: Text(
        AppString.changedSystemLanguageMsg.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      connent: Text(AppString.askShutDownMsg.tr),
    );
  }

  static Future<bool> errorNoEnrolledEmail() async {
    return selectionDialog(
      title: Text(
        AppString.errorCreateEmail1.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
      connent: Text(AppString.errorCreateEmail2.tr),
    );
  }

  static Future<bool> selectionDialog({Widget? title, Widget? connent}) async {
    return jonggackDialog(
      title: title,
      connent: connent,
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => Get.back(result: true),
              child: Padding(
                padding: EdgeInsets.all(Responsive.width15),
                child: Text(
                  AppString.yesBtn.tr,
                  style: TextStyle(
                    fontSize: Responsive.height14,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.height10),
          Card(
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () => Get.back(result: false),
              child: Padding(
                padding: EdgeInsets.all(Responsive.width15),
                child: Text(
                  AppString.noBtn.tr,
                  style: TextStyle(
                    fontSize: Responsive.height14,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JonggackAvator extends StatelessWidget {
  const JonggackAvator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width10 * 11,
      height: Responsive.width10 * 11,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/my_avator.jpeg',
          ),
        ),
      ),
    );
  }
}
