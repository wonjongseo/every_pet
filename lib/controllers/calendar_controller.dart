import 'dart:collection';

import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/widgets/custom_text_feild.dart';
import 'package:every_pet/controllers/stamp_controller.dart';
import 'package:every_pet/models/stamp_model.dart';
import 'package:every_pet/models/todo_model.dart';
import 'package:every_pet/respository/todo_repository.dart';
import 'package:every_pet/view/calendar/calendar_screen.dart';
import 'package:every_pet/view/calendar/widgets/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  final kToday = DateTime.now();
  late DateTime kFirstDay;
  late DateTime kLastDay;
  StampController stampController = Get.put(StampController());

  DateTime _focusedDay = DateTime.now();

  DateTime get focusedDay => _focusedDay;
  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;

  // List<StampModel> stamps = tempStamps;

  TodoRepository todoRepository = TodoRepository();

  List<TodoModel>? getFocusedDayEvent() {
    return kEvents[focusedDay];
  }

  bool isNotEmptyFocusedDayEvent() {
    if (getFocusedDayEvent() == null) {
      return false;
    } else if (getFocusedDayEvent()!.isEmpty) {
      return false;
    } else if (getFocusedDayEvent()![0].stamps.isEmpty &&
        getFocusedDayEvent()![0].memo.isEmpty) {
      return false;
    }

    return true;
  }

  CalendarFormat calendarFormat = CalendarFormat.month;
  void onFormatChanged(CalendarFormat format) {
    if (format != calendarFormat) {
      return;
    }
    calendarFormat = format;
    update();
  }

  final kEvents = LinkedHashMap<DateTime, List<TodoModel>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void onInit() {
    super.onInit();

    kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

    _selectedDay = _focusedDay;
    getTodos();
  }

  void getTodos() async {
    List<TodoModel> todoModels = await todoRepository.getTodos();

    for (var todoModel in todoModels) {
      if (kEvents[todoModel.dateTime] == null) {
        kEvents[todoModel.dateTime] = [];
      }
      kEvents[todoModel.dateTime]!.add(todoModel);
    }
    update();
  }

  void onDaySelected(
    BuildContext context,
    DateTime selectedDay,
    DateTime focusedDay,
  ) async {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    update();

    showBottomSheet(
      context: context,
      builder: (context) {
        return const BottomSheetWidget();
      },
    );
  }

  List<StampModel> getSavedStampIndex() {
    List<StampModel> savedStampIndex = [];
    if (kEvents[focusedDay] == null) {
      return [];
    }

    for (var stamps in kEvents[focusedDay]![0].stamps) {
      savedStampIndex.add(stamps);
    }

    return savedStampIndex;
  }

  bool isSaved(int index) {
    if (kEvents[focusedDay] == null) {
      return false;
    }

    for (var stamps in kEvents[focusedDay]![0].stamps) {
      if (stamps.iconIndex == index) {
        return true;
      }
    }
    return false;
  }

  void clickAddbtn() async {
    final result = await Get.dialog(
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: Responsive.width15),
              content: const CustomAlertDialog(),
            ),
          ),
        ),
      ),
    );

    if (result == null) {
      return;
    }

    if (!(result as Map<String, dynamic>).containsKey('selectedStamps') ||
        !(result).containsKey('memo')) {
      return;
    }
    String memo = result['memo'];

    List<StampModel> selectedStamps =
        result['selectedStamps'] as List<StampModel>;

    TodoModel todoModel = TodoModel(
      stamps: selectedStamps,
      memo: memo,
      dateTime: focusedDay,
    );

    if (selectedStamps.isEmpty && (memo == null || memo.isEmpty)) {
      if (kEvents[focusedDay] != null) {
        if (kEvents[focusedDay]!.isNotEmpty) {
          todoRepository.deleteTodo(kEvents[focusedDay]![0]);
          kEvents[focusedDay]!.remove(kEvents[focusedDay]![0]);
        }
      }
    } else {
      kEvents[focusedDay] = [];
      kEvents[focusedDay]!.add(todoModel);
      todoRepository.saveTodo(todoModel);
    }

    update();
  }

  List<TodoModel> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }
}
