import 'dart:developer';

import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/expensive_controller.dart';
import 'package:every_pet/view/expensive/add_expensive_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ExpensiveScreen extends StatefulWidget {
  const ExpensiveScreen({super.key});

  @override
  State<ExpensiveScreen> createState() => _ExpensiveScreenState();
}

class _ExpensiveScreenState extends State<ExpensiveScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  ExpensiveController expensiveController = Get.put(ExpensiveController());

  GlobalKey todayKey = GlobalKey();

  int totalPrice = 0;
  DateTime now = DateTime.now();
  List<DateTime> days = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    days = _generateMonthDays(now);

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToTodayIndex());
  }

  void _changeMonth(int offset) {
    now = DateTime(now.year, now.month + offset, 1);
    days = _generateMonthDays(now);
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToTodayIndex());
  }

  void _scrollToTodayIndex() {
    if (now.year == DateTime.now().year && now.month == DateTime.now().month) {
      final idx = DateTime.now().day - 1;
      if (itemScrollController.isAttached) {
        itemScrollController.scrollTo(
          index: idx,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: 0.3, // 살짝 아래에 위치
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List<DateTime> _generateMonthDays(DateTime date) {
    int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    return List.generate(
        daysInMonth, (index) => DateTime(date.year, date.month, index + 1));
  }

  void scrollGoToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('y${AppString.yearText.tr}').format(now),
                style: headingStyle,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => _changeMonth(-1),
                  ),
                  SizedBox(width: Responsive.width10),
                  Text(
                    AppFunction.isEn()
                        ? DateFormat('MMMM').format(now)
                        : '${now.month}${AppString.monthText.tr}',
                    style: headingStyle,
                  ),
                  SizedBox(width: Responsive.width10),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
              InkWell(
                onTap: _scrollToTodayIndex,
                child: Container(
                  padding: EdgeInsets.all(Responsive.height10 * .4),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    AppString.todayText.tr,
                    style: headingStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ScrollablePositionedList.separated(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: days.length,
            separatorBuilder: (_, __) => const Divider(thickness: .3),
            itemBuilder: (context, index) {
              return Obx(() {
                final expensives =
                    expensiveController.expensivesByDay(days[index]);
                return ListTile(
                  title: Text(
                    DateFormat.MMMEd(Get.locale.toString()).format(days[index]),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  isThreeLine: expensives.isNotEmpty,
                  trailing: expensives.isEmpty
                      ? const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black,
                        )
                      : null,
                  subtitle: expensives.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: List.generate(
                                  expensives.length,
                                  (i) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(expensives[i].productName),
                                        Text('${AppString.moneySign.tr} '
                                            '${NumberFormat("#,###").format(expensives[i].price)}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                  onTap: () => Get.to(
                      () => AddExpensiveScreen(selectedDay: days[index])),
                );
              });
            },
          ),
        ),
        Obx(() {
          expensiveController.calculateTotalPricePerMonth(now.month);
          return GestureDetector(
            onTap: () {
              Get.dialog(
                name: "totalPriceDialog",
                AlertDialog(
                  content: expensiveController.categoryAndPrice.isEmpty
                      ? Text(
                          AppFunction.isEn()
                              ? '${AppString.noCostMsg.tr}${DateFormat('MMMM').format(now)}'
                              : '${now.month}${AppString.monthText.tr}${AppString.noCostMsg.tr}',
                          textAlign: TextAlign.center,
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: expensiveController.categoryAndPrice.entries
                              .map((entry) {
                            return ListTile(
                              tileColor: Colors.transparent,
                              title: Row(
                                children: [
                                  Text('${entry.key}:'),
                                  const Spacer(),
                                  Text(
                                    '${AppString.moneySign.tr}${NumberFormat("#,###").format(entry.value)}',
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.width20,
                vertical: Responsive.height20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.width20,
                vertical: Responsive.height10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppFunction.isEn()
                        ? DateFormat('MMMM').format(now)
                        : '${now.month}${AppString.monthText.tr}',
                    style: subHeadingStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        AppString.totalPrice.tr,
                        style: subHeadingStyle,
                      ),
                      Text(
                        '${AppString.moneySign.tr} ${NumberFormat("#,###").format(expensiveController.getPricePerMonth())}',
                        style: subHeadingStyle,
                      ),
                      SizedBox(width: Responsive.width10),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}
