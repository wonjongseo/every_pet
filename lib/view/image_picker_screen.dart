import 'dart:io';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/common.dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  List<Widget> imageList = [];
  int currentPage = 0;
  int? lastPage;

  @override
  void initState() {
    checkPermission();

    super.initState();
  }

  void checkPermission() async {
    final permission = await PhotoManager.requestPermissionExtend();

    if (!permission.hasAccess) {
      // bool result = await CommonDialog.selectionDialog(
      //   title: Text(AppString.requiredText.tr),
      //   connent: Text(AppString.requiredLibaryPermssionMsg.tr),
      // );
      // if (result) {
      //   await PhotoManager.openSetting();
      // } else {
      //   Get.back();
      // }
      return;
    }
    // if (!permission.isAuth) Get.back();

    fetchAllImages();
  }

  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if (currentPage == lastPage) return;

    fetchAllImages();
  }

  void fetchAllImages() async {
    lastPage = currentPage;

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true, // What ?
    );

    List<AssetEntity> photos = await albums[0].getAssetListPaged(
      page: currentPage,
      size: 24,
    );

    List<Widget> temp = [];

    for (var asset in photos) {
      temp.add(
        FutureBuilder(
          // future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          future: asset.originFile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  // onTap: () => Navigator.pop(context, snapshot.data),
                  onTap: () {
                    Get.back(result: snapshot.data);
                  },
                  borderRadius: BorderRadius.circular(5),
                  splashFactory: NoSplash.splashFactory,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(.4),
                        width: 1,
                      ),
                      // image: DecorationImage(
                      //   image: MemoryImage(snapshot.data as Uint8List),
                      //   fit: BoxFit.cover,
                      // ),
                      image: DecorationImage(
                        image: FileImage(snapshot.data as File),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      );
    }
    setState(() {
      imageList.addAll(temp);
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppString.selectProfile.tr,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            handleScrollEvent(scroll);
            return true;
          },
          child: GridView.builder(
            itemCount: imageList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return imageList[index];
            },
          ),
        ),
      ),
    );
  }
}
