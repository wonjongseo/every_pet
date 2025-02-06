import 'dart:developer';
import 'dart:io';

import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:every_pet/controllers/category_controller.dart';
import 'package:every_pet/controllers/expensive_controller.dart';
import 'package:every_pet/view/expensive/add_expensive_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpensiveScreen extends StatefulWidget {
  const ExpensiveScreen({super.key});

  @override
  State<ExpensiveScreen> createState() => _ExpensiveScreenState();
}

class _ExpensiveScreenState extends State<ExpensiveScreen> {
  ExpensiveController expensiveController = Get.put(ExpensiveController());

  GlobalKey todayKey = GlobalKey();

  int totalPrice = 0;
  DateTime now = DateTime.now();
  List<DateTime> days = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    log("OPEN ExpensiveScreen");
    super.initState();
    days = _generateMonthDays(now);

    setState(() {});
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

  void _changeMonth(int offset) {
    now = DateTime(now.year, now.month + offset, 1);
    days = _generateMonthDays(now);
    scrollGoToTop();
    setState(() {});
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
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
                          '${now.month}${AppString.monthText.tr}',
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
                      onTap: () {
                        Scrollable.ensureVisible(
                          todayKey.currentContext!,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.only(bottom: Responsive.height10 * .8),
                        margin: EdgeInsets.only(right: Responsive.width10 * .8),
                        decoration: BoxDecoration(
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
              SizedBox(height: Responsive.height10),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: days.length,
                  separatorBuilder: (context, index) {
                    return const Divider(thickness: .3);
                  },
                  itemBuilder: (context, index) {
                    return Obx(() {
                      var expensives =
                          expensiveController.expensivesByDay(days[index]);

                      return ListTile(
                        key: now.day - 1 == index ? todayKey : null,
                        title: Text(
                          DateFormat.MMMEd(Platform.localeName)
                              .format(days[index]),
                        ),
                        isThreeLine: expensives.isNotEmpty ? true : false,
                        subtitle: expensives.isNotEmpty
                            ? Column(
                                children: List.generate(
                                  expensives.length,
                                  (index) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(expensives[index].productName),
                                      Text(
                                          '${AppString.moneySign.tr} ${NumberFormat("#,###").format(expensives[index].price)}'),
                                    ],
                                  ),
                                ),
                              )
                            : null,
                        onTap: () {
                          Get.to(
                            () => AddExpensiveScreen(selectedDay: days[index]),
                          );
                        },
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
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: expensiveController.categoryAndPrice.entries
                              .map((entry) {
                            return ListTile(
                              tileColor: Colors.transparent,
                              title: Row(
                                children: [
                                  Text('${entry.key}:'),
                                  Spacer(),
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
                          '${now.month}${AppString.monthText.tr}',
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
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
