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
            if ((focusedDay as TodoModel).stamps.isEmpty) return null;
            return Container(
              width: Responsive.width10 * 2.5,
              height: Responsive.width10 * 2.5,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount:
                    focusedDay.stamps.length > 4 ? 4 : focusedDay.stamps.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: focusedDay.stamps[index].getColor(),
                    ),
                  );
                },
              ),
            );
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
    print('isActive : ${isActive}');

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: Responsive.height10 / 2),
      width: size.width / 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: isActive
                  ? AppColors.blueLight.withOpacity(0.5)
                  : Colors.grey.shade400,
            ),
            onPressed: onTap,
            icon: Image.asset(
              icon,
              width: Responsive.width10 * 5,
              height: Responsive.width10 * 5,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: isActive
                ? TextStyle(color: Colors.black, fontWeight: FontWeight.w500)
                : TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
