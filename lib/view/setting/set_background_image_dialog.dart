import 'dart:io';

import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/common/utilities/app_image_path.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/view/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SetBackgroundImageDialog extends StatefulWidget {
  const SetBackgroundImageDialog(
      {super.key,
      required this.selectedPath,
      required this.selectedSource,
      required this.selectedOpacity});

  final String selectedPath;
  final String selectedSource;
  final double selectedOpacity;
  @override
  State<SetBackgroundImageDialog> createState() =>
      _SetBackgroundImageDialogState();
}

class _SetBackgroundImageDialogState extends State<SetBackgroundImageDialog> {
  String selectedPath = "";
  String selectedSource = "";
  double selectedOpacity = 0.5;
  SettingController settingController = Get.find<SettingController>();
  @override
  void initState() {
    super.initState();
    selectedPath = widget.selectedPath;
    selectedSource = widget.selectedSource;
    selectedOpacity = widget.selectedOpacity;
  }

  Widget _backgroundOptionTile({
    required String title,
    required String imagePath,
    required String valuePath,
    required String valueSource,
    required String selectedPath,
    required String selectedSource,
    required void Function(String path, String source) onChanged,
  }) {
    return ListTile(
      leading: _backgroundPreview(imagePath, valueSource),
      title: Text(title),
      trailing: Radio<String>(
        value: valuePath,
        groupValue: selectedSource == valueSource ? selectedPath : '',
        onChanged: (_) => onChanged(valuePath, valueSource),
      ),
      onTap: () => onChanged(valuePath, valueSource),
    );
  }

  Future<String?> _pickBackgroundImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedImage == null) return null;

    final croppedImage = await AppFunction.cropImage(pickedImage.path);
    if (croppedImage == null) return null;

    return AppFunction.saveFileFromTempDirectory(
      croppedImage.path,
      'background_${DateTime.now().microsecondsSinceEpoch}',
    );
  }

  Widget _backgroundPreview(String? imagePath, String source) {
    const size = 42.0;
    final hasImage = imagePath != null && imagePath.isNotEmpty;
    final image = source == AppConstant.backgroundImageSourceFile && hasImage
        ? Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image),
          )
        : Image.asset(
            imagePath ?? AppImagePath.bisyon,
            fit: BoxFit.cover,
          );

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppString.changeBackgroundText.tr),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _backgroundOptionTile(
              title: AppString.dogTextTr.tr,
              imagePath: AppImagePath.bisyon,
              valuePath: AppImagePath.bisyon,
              valueSource: AppConstant.backgroundImageSourceAsset,
              selectedPath: selectedPath,
              selectedSource: selectedSource,
              onChanged: (path, source) {
                setState(() {
                  selectedPath = path;
                  selectedSource = source;
                });
              },
            ),
            _backgroundOptionTile(
              title: AppString.catTextTr.tr,
              imagePath: AppImagePath.defaultCat,
              valuePath: AppImagePath.defaultCat,
              valueSource: AppConstant.backgroundImageSourceAsset,
              selectedPath: selectedPath,
              selectedSource: selectedSource,
              onChanged: (path, source) {
                setState(() {
                  selectedPath = path;
                  selectedSource = source;
                });
              },
            ),
            ListTile(
              leading: _backgroundPreview(
                selectedSource == AppConstant.backgroundImageSourceFile
                    ? selectedPath
                    : null,
                AppConstant.backgroundImageSourceFile,
              ),
              title: Text(AppString.customBackgroundText.tr),
              trailing: Radio<String>(
                value: AppConstant.backgroundImageSourceFile,
                groupValue: selectedSource,
                onChanged: (_) async {
                  final savedPath = await _pickBackgroundImage();
                  if (savedPath == null) return;
                  setState(() {
                    selectedPath = savedPath;
                    selectedSource = AppConstant.backgroundImageSourceFile;
                  });
                },
              ),
              onTap: () async {
                final savedPath = await _pickBackgroundImage();
                if (savedPath == null) return;
                setState(() {
                  selectedPath = savedPath;
                  selectedSource = AppConstant.backgroundImageSourceFile;
                });
              },
            ),
            SizedBox(height: Responsive.height10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${AppString.backgroundOpacityText.tr} ${(selectedOpacity * 100).round()}%',
              ),
            ),
            Slider(
              value: selectedOpacity,
              min: 0,
              max: 1,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  selectedOpacity = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text(AppString.cancelBtnTextTr.tr),
        ),
        TextButton(
          onPressed: () async {
            await settingController.updateBackground(
              imagePath: selectedPath,
              imageSource: selectedSource,
              opacity: selectedOpacity,
            );
            Get.back();
          },
          child: Text(AppString.applyText.tr),
        ),
      ],
    );
  }
}
