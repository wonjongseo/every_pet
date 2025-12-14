import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_constant.dart';
import 'package:every_pet/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickerBottomSheet extends StatefulWidget {
  const DatePickerBottomSheet({
    super.key,
    this.initialFocusedDay,
    this.initialSelectedDay,
    this.initialRangeStart,
    this.initialRangeEnd,
    this.onApply,
    this.onClear,
  });

  final DateTime? initialFocusedDay;
  final DateTime? initialSelectedDay;
  final DateTime? initialRangeStart;
  final DateTime? initialRangeEnd;

  final void Function(DateTime? start, DateTime? end)? onApply;

  final VoidCallback? onClear;

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  DateTime? _rangeStartDay;
  DateTime? _rangeEndDay;
  DateTime now = DateTime.now();
  RangeSelectionMode _mode = RangeSelectionMode.toggledOn;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialFocusedDay ?? DateTime.now();
    _selectedDay = widget.initialSelectedDay;
    _rangeStartDay = widget.initialRangeStart;
    _rangeEndDay = widget.initialRangeEnd;

    if (_selectedDay != null) {
      _mode = RangeSelectionMode.toggledOff;
    } else {
      _mode = RangeSelectionMode.toggledOn;
    }
  }

  void _onDaySelected(DateTime selected, DateTime focused) {
    setState(() {
      _selectedDay = selected;
      _focusedDay = focused;

      _rangeStartDay = null;
      _rangeEndDay = null;
    });
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focused) {
    setState(() {
      _focusedDay = focused;
      _rangeStartDay = start;
      _rangeEndDay = end;

      _selectedDay = null;
      _mode = RangeSelectionMode.toggledOn;
    });
  }

  void _apply() {
    if (widget.onApply == null) {
      Get.back();
      return;
    }
    if (_selectedDay != null) {
      widget.onApply!(_selectedDay, _selectedDay);
    } else {
      widget.onApply!(_rangeStartDay, _rangeEndDay);
    }
    Get.back();
  }

  void _clear() {
    setState(() {
      _selectedDay = null;
      _rangeStartDay = null;
      _rangeEndDay = null;
      _mode = RangeSelectionMode.toggledOn;
    });
    widget.onClear?.call();
    Get.back();
  }

  void _moveMonth(bool isForward) {
    final data = DateTime(
      _focusedDay.year,
      isForward ? _focusedDay.month + 1 : _focusedDay.month - 1,
      1,
    );

    setState(() {
      _focusedDay = data;
      checkCanMove();
    });
  }

  void checkCanMove() {
    const firstYear = AppConstant.dateTimePickerFirstYear;

    bool next;
    if (_focusedDay.year < now.year) {
      next = true;
    } else if (_focusedDay.year == now.year) {
      next = _focusedDay.month < now.month;
    } else {
      next = false;
    }

    bool prev;
    if (_focusedDay.year > firstYear) {
      prev = true;
    } else if (_focusedDay.year == firstYear) {
      prev = _focusedDay.month > 1;
    } else {
      prev = false;
    }

    setState(() {
      canMoveNext = next;
      canMovePrev = prev;
    });
  }

  bool canMoveNext = false;
  bool canMovePrev = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _dateNavigator(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SizedBox(
              width: double.infinity,
              height: size.height * .6,
              child: TableCalendar(
                headerVisible: false,
                locale: 'ja_JP',
                firstDay: DateTime.utc(
                  AppConstant.dateTimePickerFirstYear,
                  1,
                  1,
                ),
                lastDay: now,
                shouldFillViewport: true,
                focusedDay: _focusedDay,
                rangeSelectionMode: _mode,
                rangeStartDay: _rangeStartDay,
                rangeEndDay: _rangeEndDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onPageChanged: (f) {
                  setState(() {
                    _focusedDay = f;
                  });
                  return;
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          _bottomButtons(),
        ],
      ),
    );
  }

  Padding _bottomButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              label: "クリア",
              onTap: _clear,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomButton(
              label: "適用",
              onTap: _apply,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Row _dateNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: canMovePrev
              ? () {
                  _moveMonth(false);
                }
              : null,
          icon: Icon(Icons.arrow_left, size: 40),
        ),
        Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                Get.dialog(
                  name: "/yearAndMonthPicker",
                  YearAndMonthPicker(
                    focusedDay: _focusedDay,
                    onTap: (p0) {
                      setState(() {
                        _focusedDay = p0;
                      });
                      checkCanMove();
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset(0, 4),
                      color: Colors.black.withValues(alpha: .1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.yMMM("ja_JP").format(_focusedDay)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: Colors.black87),
                  ],
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: canMoveNext
              ? () {
                  _moveMonth(true);
                }
              : null,
          icon: Icon(Icons.arrow_right, size: 40),
        ),
      ],
    );
  }
}

class YearAndMonthPicker extends StatefulWidget {
  const YearAndMonthPicker({required this.focusedDay, required this.onTap});
  final DateTime focusedDay;
  final Function(DateTime) onTap;
  @override
  State<YearAndMonthPicker> createState() => YearAndMonthPickerState();
}

class YearAndMonthPickerState extends State<YearAndMonthPicker> {
  late DateTime focusedDay;
  bool isSelectedMonth = true;

  late int year;
  late int month;
  List<int> years = [];

  final now = DateTime.now();

  @override
  void initState() {
    focusedDay = widget.focusedDay;
    year = focusedDay.year;
    month = focusedDay.month;

    years = List.generate(9, (index) => now.year - index);
    years = years.reversed.toList();

    super.initState();
  }

  void onTapMonth(int month) {
    this.month = month;
    final date = DateTime(year, this.month);
    widget.onTap(date);
    setState(() {
      focusedDay = date;
    });
  }

  void onTapYear(int year) {
    this.year = year;
    if (this.year == now.year) {
      if (now.month < month) {
        month = now.month;
      }
    }

    final date = DateTime(this.year, month);

    widget.onTap(date);
    setState(() {
      focusedDay = date;
    });
  }

  Widget _yearAndMonthNavigator({
    required String label,
    required bool isMonth,
  }) {
    final month = isMonth == isSelectedMonth;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelectedMonth = isMonth;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: month ? AppColors.primaryColor : null,
          ),
          child: Row(
            children: [
              Text(label, style: TextStyle(color: month ? Colors.white : null)),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                color: month ? Colors.white : Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _getContainerColor(bool isEnable, bool isSelected) {
    return isEnable
        ? isSelected
            ? AppColors.primaryColor
            : Colors.white
        : Colors.black12;
  }

  Color? _getTextColor(bool isEnable, bool isSelected) {
    return isEnable
        ? isSelected
            ? Colors.white
            : null
        : Colors.black26;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      content: Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _yearAndMonthNavigator(
                  label: "${focusedDay.year}年",
                  isMonth: false,
                ),
                SizedBox(width: 24),
                _yearAndMonthNavigator(
                  label: "${focusedDay.month}月",
                  isMonth: true,
                ),
              ],
            ),
            SizedBox(height: 20),
            if (isSelectedMonth) _monthNavigator() else _yearNavigator(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  bool isCantMoveForward = true;
  bool isCantMoveBack = false;

  void moveYears(bool isBack) {
    if (isBack) {
      int beforeYear = years.first - 1;
      years = List.generate(9, (index) => beforeYear - index);
      years = years.reversed.toList();
    } else {
      int nextYear = years.last + 1;
      years = List.generate(9, (index) => nextYear + index);
    }
    isCantMoveForward = years.contains(now.year);
    isCantMoveBack = years.contains(AppConstant.dateTimePickerFirstYear);

    setState(() {});
  }

  Widget _yearNavigator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: isCantMoveBack
              ? null
              : () {
                  moveYears(true);
                },
          icon: Icon(Icons.arrow_left),
        ),
        Expanded(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: List.generate(years.length, (index) {
              int year = years[index];
              bool isSelected = focusedDay.year == year;
              bool isEnable = year >= AppConstant.dateTimePickerFirstYear;
              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: isEnable ? () => onTapYear(years[index]) : null,
                  child: Container(
                    width: 55,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _getContainerColor(isEnable, isSelected),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      years[index].toString(),
                      style: TextStyle(
                        color: _getTextColor(isEnable, isSelected),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        IconButton(
          onPressed: isCantMoveForward
              ? null
              : () {
                  moveYears(false);
                },
          icon: Icon(Icons.arrow_right),
        ),
      ],
    );
  }

  Widget _monthNavigator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(12, (index) {
          int month = index + 1;
          bool isEnable =
              focusedDay.year == now.year ? now.month >= month : true;
          bool isSelected = focusedDay.month == month;
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: isEnable
                  ? () {
                      onTapMonth(month);
                    }
                  : null,
              child: Container(
                width: 50,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _getContainerColor(isEnable, isSelected),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "$month",
                  style: TextStyle(color: _getTextColor(isEnable, isSelected)),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
