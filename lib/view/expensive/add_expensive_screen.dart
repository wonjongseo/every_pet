import 'dart:async';

import 'package:every_pet/background2.dart';
import 'package:every_pet/common/admob/global_banner_admob.dart';
import 'package:every_pet/common/utilities/app_color.dart';
import 'package:every_pet/common/utilities/app_string.dart';
import 'package:every_pet/common/utilities/snackbar_helper.dart';
import 'package:every_pet/controllers/expensive_controller.dart';
import 'package:every_pet/models/expensive_model.dart';
import 'package:every_pet/view/expensive/widgets/exensive_input_card.dart';
import 'package:every_pet/view/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:every_pet/common/theme/theme.dart';
import 'package:every_pet/common/utilities/responsive.dart';
import 'package:every_pet/common/utilities/util_function.dart';
import 'package:get/get.dart';

class AddExpensiveScreen extends StatefulWidget {
  static String name = '/add_expensive';
  const AddExpensiveScreen({super.key, required this.selectedDay});

  final DateTime selectedDay;
  @override
  State<AddExpensiveScreen> createState() => _AddExpensiveScreenState();
}

class _AddExpensiveScreenState extends State<AddExpensiveScreen> {
  ExpensiveController expensiveController = Get.find<ExpensiveController>();

  StreamController streamController = StreamController();

  @override
  void initState() {
    super.initState();
    streamController.stream.listen((event) {
      String selectedCategory = event['selectedCategory'];
      String productName = event['productName'];
      String price = event['price'];

      ExpensiveModel expensiveModel = ExpensiveModel(
        category: selectedCategory,
        productName: productName,
        price: int.parse(price),
        date: widget.selectedDay,
      );

      expensiveController.saveExpensive(expensiveModel);
      setState(() {}); // Dont' Remote
      SnackBarHelper.showSuccessSnackBar(
        '${expensiveModel.productName}${AppString.doneAddtionMsg.tr}',
      );
    });
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  void deleteExpensive(ExpensiveModel expensiveModel) async {
    expensiveController.delete(expensiveModel);

    SnackBarHelper.showSuccessSnackBar(
        '${expensiveModel.productName}${AppString.doneDeletionMsg.tr}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: const GlobalBannerAdmob(),
      body: BackGround2(
        widget: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Responsive.height10 * .8,
                horizontal: Responsive.width10 * 2,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: Responsive.width18,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: Responsive.width10),
                        Text(
                          AppFunction.getDayYYYYMMDD(widget.selectedDay),
                          style: headingStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.height14),
                    ExpensiveInputCard(streamController: streamController),
                    Obx(
                      () {
                        var expensiveModels = expensiveController
                            .expensivesByDay(widget.selectedDay);
                        if (expensiveModels.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        final total = expensiveModels.fold<int>(
                          0,
                          (sum, item) => sum + item.price,
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Responsive.height10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.width14,
                                vertical: Responsive.height10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.receipt_long_outlined,
                                    size: Responsive.width18,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: Responsive.width10),
                                  Text(
                                    AppString.expensiveTextTr.tr,
                                    style: subHeadingStyle,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${AppString.moneySign.tr} ${NumberFormat("#,###").format(total)}',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: Responsive.width15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Responsive.height10),
                            ...List.generate(
                              expensiveModels.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: Responsive.height10,
                                ),
                                child: _ExpensiveListTile(
                                  expensive: expensiveModels[index],
                                  onDelete: () => deleteExpensive(
                                    expensiveModels[index],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: Responsive.height10 * 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpensiveListTile extends StatelessWidget {
  const _ExpensiveListTile({
    required this.expensive,
    required this.onDelete,
  });

  final ExpensiveModel expensive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width14,
        vertical: Responsive.height10,
      ),
      decoration: BoxDecoration(
        color: SettingController.to.blackOrWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(.28)),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.width10 * 4,
            height: Responsive.width10 * 4,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.payments_outlined,
              size: Responsive.width20,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: Responsive.width10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expensive.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Responsive.width15,
                    fontWeight: FontWeight.w700,
                    color: SettingController.to.realBlackOrWhite,
                  ),
                ),
                SizedBox(height: Responsive.height10 / 3),
                Text(
                  expensive.displayCategory,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Responsive.width14 * .9,
                    color:
                        SettingController.to.realBlackOrWhite.withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.width10),
          Text(
            '${AppString.moneySign.tr} ${NumberFormat("#,###").format(expensive.price)}',
            style: TextStyle(
              fontSize: Responsive.width15,
              fontWeight: FontWeight.w800,
              color: SettingController.to.realBlackOrWhite,
            ),
          ),
          SizedBox(width: Responsive.width10 / 2),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.delete_outline,
              color: AppColors.secondaryColor,
              size: Responsive.width20,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
