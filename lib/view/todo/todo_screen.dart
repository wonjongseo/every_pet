import 'dart:collection';
import 'dart:developer';

import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:every_pet/common/utilities/responsive.dart';
// import 'package:every_pet/event.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("OPEN TodoScreen");
    return GetBuilder<TodoController>(builder: (contoller) {
      return TableCalendar(
        locale: Get.locale.toString(),
        shouldFillViewport: true,
        firstDay: contoller.kFirstDay,
        lastDay: contoller.kLastDay,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        focusedDay: contoller.focusedDay,
        selectedDayPredicate: (day) => isSameDay(contoller.selectedDay, day),
        calendarBuilders: CalendarBuilders(
          singleMarkerBuilder: (context, day, focusedDay) {
            if ((focusedDay as TodoModel).stamps.isEmpty) return null;
            return SizedBox(
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

          // headerTitleBuilder: (context, day) {
          //   final DateFormat dateFormat = DateFormat('yyyy年M月');
          //   return Text(dateFormat.format(contoller.focusedDay),
          //       style: const TextStyle(fontSize: 16));
          // },
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
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: Responsive.height10 / 2),
      width: size.width / 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(Responsive.width10 * 5),
            child: Container(
              width: Responsive.width10 * 5,
              height: Responsive.width10 * 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(icon),
                ),
                color: isActive
                    ? AppColors.primaryColor.withOpacity(0.5)
                    : Colors.grey.shade400,
              ),
              child: isActive ? const Icon(Icons.check) : null,
            ),
          ),
          // IconButton(
          //   style: IconButton.styleFrom(
          //     padding: EdgeInsets.zero,
          //     backgroundColor: isActive
          //         ? AppColors.primaryColor.withOpacity(0.5)
          //         : Colors.grey.shade400,
          //   ),
          //   onPressed: onTap,
          //   icon: Image.asset(
          //     icon,
          //     width: Responsive.width10 * 5,
          //     height: Responsive.width10 * 5,
          //   ),
          // ),
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
