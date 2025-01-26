import 'dart:collection';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/controllers/calendar_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/common/widgets/short_bar.dart';
// import 'package:every_pet/event.dart';
import 'package:every_pet/sample_pages/event_example.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CalendarController());
    return GetBuilder<CalendarController>(builder: (contoller) {
      return TableCalendar(
        shouldFillViewport: true,
        firstDay: contoller.kFirstDay,
        lastDay: contoller.kLastDay,
        focusedDay: contoller.focusedDay,
        selectedDayPredicate: (day) => isSameDay(contoller.selectedDay, day),
        calendarBuilders: CalendarBuilders(
          // dowBuilder: (_, day) {
          //   final text = DateFormat.E('ja').format(day);
          //   if (day.weekday == DateTime.sunday) {
          //     return Center(
          //       child: Text(text,
          //           style: const TextStyle(
          //               color: Colors.red, fontWeight: FontWeight.bold)),
          //     );
          //   } else if (day.weekday == DateTime.saturday) {
          //     return Center(
          //       child: Text(
          //         text,
          //         style: const TextStyle(
          //             color: Colors.blue, fontWeight: FontWeight.bold),
          //       ),
          //     );
          //   }
          //   return null;
          // },
          // defaultBuilder: (context, day, focusedDay) {
          //   return Text('defaultBuilder');
          // },
          // rangeHighlightBuilder: (context, day, focusedDay) {
          //   return Text('rangeHighlightBuilder');
          // },
          singleMarkerBuilder: (context, day, focusedDay) {
            print('focusedDay : ${focusedDay}');
            if ((focusedDay as TodoModel).stamps.isEmpty) return null;
            return Padding(
              padding: EdgeInsets.only(top: Responsive.height10 * .4),
              child: Text(
                '${(focusedDay).stamps.length}個',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
            // return Column(
            //   children: List.generate(
            //     (focusedDay).stamps.length > 3 ? 4 : (focusedDay).stamps.length,
            //     (index) {
            //       if (index == 3) {
            //         return Text('...');
            //       }
            //       return Text('トリミング');
            //       // return Text((focusedDay).stamps[index].name);
            //     },
            //   ),
            // );
            // return Text('singleMarkerBuilder');
          },
          // markerBuilder: (context, day, focusedDay) {
          //   return Text('markerBuilder');
          // },

          headerTitleBuilder: (context, day) {
            final DateFormat dateFormat = DateFormat('yyyy年M月');
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(dateFormat.format(contoller.focusedDay),
                    style: const TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    // setState(() {
                    //   _focusedDay = DateTime.now();
                    // })
                  },
                  child: const Text('今日'),
                )
              ],
            );
          },
        ),
        eventLoader: contoller.getEventsForDay,
        onFormatChanged: contoller.onFormatChanged,
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: true,
        ),
        onDaySelected: (selectedDay, focusedDay) => contoller.onDaySelected(
          context,
          selectedDay,
          focusedDay,
        ),
      );
    });
  }
}

class ColIconButton extends StatelessWidget {
  const ColIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width10 * 5,
      margin: EdgeInsets.symmetric(
        vertical: Responsive.height10 * .4,
        horizontal: Responsive.width10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: isActive
                  ? AppColors.blueLight.withOpacity(0.5)
                  : Colors.grey.shade400,
            ),
            onPressed: onTap,
            icon: Image.asset(icon),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


 // void showBottomSheet() async {
  //   await showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Column(
  //         children: [
  //           Align(
  //             alignment: Alignment.centerRight,
  //             child: TextButton(
  //               onPressed: () async {
  //                 List<int> selectedIndexs = [];
  //                 TextEditingController memoController =
  //                     TextEditingController(text: 'TEMP Memo');

  //                 await Get.dialog(
  //                   AlertDialog(
  //                     content: StatefulBuilder(builder: (context, setState2) {
  //                       return Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               const Text('メモ'),
  //                               CustomTextField(
  //                                 maxLines: 2,
  //                                 controller: memoController,
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(height: Responsive.height10),
  //                           Wrap(
  //                             children: List.generate(
  //                               stamps.length,
  //                               (index) => ColIconButton(
  //                                 icon: stamps[index].icon,
  //                                 label: stamps[index].name,
  //                                 onTap: () {
  //                                   if (selectedIndexs.contains(index)) {
  //                                     selectedIndexs.remove(index);
  //                                   } else {
  //                                     selectedIndexs.add(index);
  //                                   }
  //                                   setState2(() {});
  //                                 },
  //                                 isActive: selectedIndexs.contains(index),
  //                               ),
  //                             ),
  //                           ),
  //                           Align(
  //                               alignment: Alignment.centerRight,
  //                               child: TextButton(
  //                                   onPressed: () {}, child: Text('カスタマイズ'))),
  //                           ElevatedButton(
  //                               onPressed: () {
  //                                 List<StampModel> selectedStamps = [];
  //                                 for (var index in selectedIndexs) {
  //                                   selectedStamps.add(stamps[index]);
  //                                 }

  //                                 TodoModel todoModel = TodoModel(
  //                                   stamps: selectedStamps,
  //                                   memo: memoController.text,
  //                                   dateTime: _focusedDay,
  //                                 );
  //                                 if (_kEvents[_focusedDay] == null) {
  //                                   _kEvents[_focusedDay] = [];
  //                                 }
  //                                 _kEvents[_focusedDay]!.add(todoModel);
  //                                 setState(() {});
  //                                 Get.back();
  //                                 Get.back();
  //                               },
  //                               child: const Text('保存')),
  //                         ],
  //                       );
  //                     }),
  //                   ),
  //                 );
  //               },
  //               child: Text('予定を追加'),
  //             ),
  //           ),
  //           if (_kEvents[_focusedDay] == null || _kEvents[_focusedDay]!.isEmpty)
  //             const Text(
  //               'まだ予定がありません。',
  //               style: TextStyle(
  //                 fontSize: 18,
  //               ),
  //             )
  //           else
  //             Column(
  //               children: List.generate(
  //                 _kEvents[_focusedDay]![0].stamps.length,
  //                 (index) => Row(
  //                   children: [
  //                     Icon(_kEvents[_focusedDay]![0].stamps[index].icon),
  //                     Text(_kEvents[_focusedDay]![0].stamps[index].name),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //         ],
  //       );

  //       // return Container(
  //       //   width: double.infinity,
  //       //   padding: EdgeInsets.symmetric(horizontal: 20),
  //       //   child: Column(
  //       //     mainAxisSize: MainAxisSize.min,
  //       //     children: [
  //       //       const ShortHBar(),
  //       //       SizedBox(height: 20),
  //       //       Column(
  //       //         mainAxisSize: MainAxisSize.min,
  //       //         children: [
  //       //           Align(
  //       //             alignment: Alignment.centerLeft,
  //       //             child: Text(
  //       //               UtilFunction.getDayYYYYMMDD(
  //       //                   _selectedDay ?? DateTime.now()),
  //       //               style: TextStyle(
  //       //                 fontWeight: FontWeight.bold,
  //       //                 fontSize: Responsive.width20,
  //       //               ),
  //       //             ),
  //       //           ),
  //       //           Align(
  //       //             alignment: Alignment.centerRight,
  //       //             child: TextButton(
  //       //               onPressed: () {},
  //       //               child: Text('カスタマイズ'),
  //       //             ),
  //       //           ),
  //       //           SizedBox(height: 20),
  //       //           Wrap(
  //       //             children: List.generate(
  //       //               stamps.length,
  //       //               (index) => ColIconButton(
  //       //                 icon: stamps[index].icon,
  //       //                 label: stamps[index].name,
  //       //                 onTap: () {},
  //       //                 isActive: selectedIndexs.contains(index),
  //       //               ),
  //       //             ),
  //       //           ),
  //       //         ],
  //       //       ),
  //       //       SizedBox(height: 50),
  //       //     ],
  //       //   ),
  //       // );
  //     },
  //   );
  // }