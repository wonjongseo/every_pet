import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/view/stamp_custom/widgets/enroll_stamp_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StampCustomScreen extends StatefulWidget {
  const StampCustomScreen({super.key});

  @override
  State<StampCustomScreen> createState() => _StampCustomScreenState();
}

class _StampCustomScreenState extends State<StampCustomScreen> {
  // List<TextEditingController> textEditingControllers = [];
  // List<TextEditingController>? newTextEditingControllers;

  StampController controller = Get.find<StampController>();

  // bool isReadOnly = true;
  // List<StampModel>? newStamp;
  @override
  void initState() {
    super.initState();

    // for (var stamp in controller.stamps) {
    //   textEditingControllers.add(TextEditingController(text: stamp.name));
    // }
  }

  @override
  void dispose() {
    // for (var textEditingController in textEditingControllers) {
    //   textEditingController.dispose();
    // }
    super.dispose();
  }

  String value = 'a';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.changeStampTextTr.tr),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.dialog(AlertDialog(
                insetPadding:
                    EdgeInsets.symmetric(horizontal: Responsive.width15),
                content: const EnrollStampDialog(),
              ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: GetBuilder<StampController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: Responsive.width20,
              bottom: Responsive.width20,
              left: Responsive.width20,
              right: Responsive.width10,
            ),
            child: Column(
              children: [
                Column(
                  children: List.generate(
                    controller.stamps.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                StampModel.getIcon(
                                    controller.stamps[index].iconIndex),
                              ),
                            ),
                            SizedBox(width: Responsive.width10),
                            Expanded(
                              child: CustomTextField(
                                // controller: textEditingControllers[index],
                                maxLines: 1,
                                hintText: controller.stamps[index].name,
                                onTap: () {
                                  Get.dialog(AlertDialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: Responsive.width15,
                                    ),
                                    content: EnrollStampDialog(
                                        stamp: controller.stamps[index]),
                                  ));
                                },
                                readOnly: true,
                                // readOnly: isReadOnly,
                              ),
                            ),
                            Checkbox(
                              value: controller.stamps[index].isVisible,
                              onChanged: (v) =>
                                  controller.toogleVisualbe(index),
                            ),
                            if (controller.stamps[index].isCustom)
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove),
                              )
                          ],
                        ),
                        // child: RowStampWidget(
                        //   stamp: controller.stamps[index],
                        // ),
                      );
                    },
                  ),
                ),
                // if (newTextEditingControllers != null)
                //   Column(
                //     children: List.generate(newTextEditingControllers!.length,
                //         (index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Row(
                //           children: [
                //             DropdownButton(
                //                 value: newStamp![index].iconIndex,
                //                 items: List.generate(
                //                   controller.addstampsIcon.length,
                //                   (index) {
                //                     return DropdownMenuItem(
                //                       value: controller
                //                           .addstampsIcon[index].iconIndex,
                //                       child: Container(
                //                         width: Responsive.width10 * 4,
                //                         height: Responsive.width10 * 4,
                //                         child: Image.asset(
                //                           StampModel.getIcon(controller
                //                               .addstampsIcon[index].iconIndex),
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 ),
                //                 onChanged: (v) {
                //                   newStamp![index].iconIndex = v!;
                //                   setState(() {});
                //                 }),
                //             SizedBox(width: Responsive.width10),
                //             Expanded(
                //               child: CustomTextField(
                //                 controller: newTextEditingControllers![index],
                //                 maxLines: 1,
                //               ),
                //             ),
                //             Checkbox(
                //               value: controller.stamps[index].isVisible,
                //               onChanged: (v) =>
                //                   controller.toogleVisualbe(index),
                //             )
                //           ],
                //         ),
                //       );
                //     }),
                //   ),
              ],
            ),
          ),
        );
      }),
      // body: GetBuilder<StampController>(
      //   builder: (controller) {
      //     return SingleChildScrollView(
      //       child: Padding(
      //         padding: EdgeInsets.only(
      //           top: Responsive.width20,
      //           bottom: Responsive.width20,
      //           left: Responsive.width20,
      //           right: Responsive.width10,
      //         ),
      //         child: Column(
      //           children: [
      //             Column(
      //               children: List.generate(
      //                 controller.stamps.length,
      //                 (index) {
      //                   return Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Row(
      //                       children: [
      //                         Container(
      //                           height: 40,
      //                           width: 40,
      //                           decoration: BoxDecoration(
      //                             color: AppColors.primaryColor.withOpacity(.5),
      //                             shape: BoxShape.circle,
      //                           ),
      //                           child: Image.asset(
      //                             controller.stamps[index].getIcon(),
      //                           ),
      //                         ),
      //                         SizedBox(width: Responsive.width10),
      //                         Expanded(
      //                           child: CustomTextField(
      //                             controller: textEditingControllers[index],
      //                             maxLines: 1,
      //                           ),
      //                         ),
      //                         Checkbox(
      //                           value: controller.stamps[index].isVisible,
      //                           onChanged: (v) =>
      //                               controller.toogleVisualbe(index),
      //                         ),
      //                         if (controller.stamps[index].isCustom)
      //                           IconButton(
      //                             onPressed: () {},
      //                             icon: Icon(Icons.remove),
      //                           )
      //                       ],
      //                     ),
      //                     // child: RowStampWidget(
      //                     //   stamp: controller.stamps[index],
      //                     // ),
      //                   );
      //                 },
      //               ),
      //             ),
      //             if (newTextEditingControllers != null)
      //               Column(
      //                 children: List.generate(newTextEditingControllers!.length,
      //                     (index) {
      //                   return Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Row(
      //                       children: [
      //                         // DropdownButton(
      //                         //   items: [
      //                         //     DropdownMenuItem(
      //                         //       value: 'a',
      //                         //       child: Container(
      //                         //         height: 40,
      //                         //         width: 40,
      //                         //         decoration: BoxDecoration(
      //                         //           color:
      //                         //               AppColors.primaryColor.withOpacity(.5),
      //                         //           shape: BoxShape.circle,
      //                         //         ),
      //                         //         child: Image.asset(
      //                         //           controller.stamps[0].getIcon(),
      //                         //         ),
      //                         //       ),
      //                         //     ),
      //                         //     DropdownMenuItem(
      //                         //       value: 'b',
      //                         //       child: Container(
      //                         //         height: 40,
      //                         //         width: 40,
      //                         //         decoration: BoxDecoration(
      //                         //           color:
      //                         //               AppColors.primaryColor.withOpacity(.5),
      //                         //           shape: BoxShape.circle,
      //                         //         ),
      //                         //         child: Image.asset(
      //                         //           controller.stamps[1].getIcon(),
      //                         //         ),
      //                         //       ),
      //                         //     ),
      //                         //   ],
      //                         //   onChanged: (v) {
      //                         //     setState(() {});
      //                         //   },
      //                         // ),

      //                         DropdownButton(
      //                             value: newStamp![index].iconIndex,
      //                             items: List.generate(
      //                               controller.addstampsIcon.length,
      //                               (index) {
      //                                 return DropdownMenuItem(
      //                                   value: controller
      //                                       .addstampsIcon[index].iconIndex,
      //                                   child: Container(
      //                                     width: 40,
      //                                     height: 40,
      //                                     child: Image.asset(controller
      //                                         .addstampsIcon[index]
      //                                         .getIcon()),
      //                                   ),
      //                                 );
      //                               },
      //                             ),
      //                             onChanged: (v) {
      //                               newStamp![index].iconIndex = v!;
      //                               setState(() {});
      //                             }),
      //                         SizedBox(width: Responsive.width10),
      //                         Expanded(
      //                           child: CustomTextField(
      //                             controller: newTextEditingControllers![index],
      //                           ),
      //                         ),
      //                         Checkbox(
      //                           value: controller.stamps[index].isVisible,
      //                           onChanged: (v) =>
      //                               controller.toogleVisualbe(index),
      //                         )
      //                       ],
      //                     ),
      //                   );
      //                 }),
      //               ),
      //             TextButton(
      //                 onPressed: () {
      //                   if (newTextEditingControllers == null) {
      //                     newTextEditingControllers = [];
      //                   }
      //                   if (newStamp == null) {
      //                     newStamp = [];
      //                   }

      //                   newStamp!.add(
      //                     StampModel(
      //                       name: '',
      //                       iconIndex: 8,
      //                       isVisible: true,
      //                       isCustom: true,
      //                     ),
      //                   );
      //                   newTextEditingControllers!.add(TextEditingController());
      //                   setState(() {});
      //                 },
      //                 child: Text('追加')),
      //           ],
      //         ),
      //       ),
      //     );

      //   },
      // ),
    );
  }
}
