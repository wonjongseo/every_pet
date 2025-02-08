import 'dart:collection';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/controllers/todo_controller.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:every_pet/view/todo/widgets/todo_small_circle.dart';
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
    return GetBuilder<TodoController>(
      builder: (contoller) {
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
              return TodoSmallCricle(focusedDay: focusedDay);
            },
          ),
          eventLoader: contoller.getEventsForDay,
          onDaySelected: (selectedDay, focusedDay) => contoller.onDaySelected(
            context,
            selectedDay,
            focusedDay,
          ),
        );
      },
    );
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
    return Column(
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
        SizedBox(width: Responsive.width10),
        AutoSizeText(
          label,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: isActive
              ? const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500)
              : const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
