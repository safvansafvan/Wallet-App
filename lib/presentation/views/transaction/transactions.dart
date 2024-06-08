import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/presentation/controllers/transaction_db_controller.dart';
import 'package:money_management_app/presentation/views/category/category.dart';
import 'package:money_management_app/presentation/views/search/search_transaction.dart';
import 'package:money_management_app/presentation/views/settings/settings.dart';
import 'package:money_management_app/presentation/views/transaction/widgets/custom_cliper_shape.dart';
import 'package:money_management_app/presentation/views/transaction/widgets/money_status_bar.dart';
import 'package:money_management_app/presentation/widgets/common_header.dart';
import 'package:money_management_app/presentation/widgets/empty_lottie.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/constant/duration.dart';
import 'package:money_management_app/utils/resouces/res.dart';

import 'widgets/transaction_field_widget.dart';

class TransactionHomeView extends StatelessWidget {
  const TransactionHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<TransactionDbController>().calculateIncomeAndExpence();
    });
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: screenSize.height * 0.19,
          width: double.infinity,
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipperShape(),
                child: Container(
                  height: screenSize.height * 0.22,
                  width: double.infinity,
                  decoration: BoxDecoration(color: CustomColors.appClr),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Get.to(() => const Settings(),
                                transition: Transition.leftToRight,
                                curve: Curves.easeOut,
                                duration: AppDuration.appDuration);
                          },
                          icon:
                              Icon(Icons.settings, color: CustomColors.kwhite),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: Platform.isIOS ? 18 : 0),
                          child: Text(
                            "WALLET APP",
                            style: CustomFuction.style(
                                fontWeight: FontWeight.w600,
                                size: 17,
                                color: CustomColors.kwhite),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await Get.to(() => const SearchTransaction(),
                                transition: Transition.rightToLeft,
                                curve: Curves.easeOut,
                                duration: AppDuration.appDuration);
                          },
                          icon: Icon(
                            Icons.search,
                            color: CustomColors.kwhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 30,
                right: 30,
                child: MoneyStatusBar(),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonHeader('Last Transations'),
              Row(
                children: [
                  GetBuilder<TransactionDbController>(builder: (ctrl) {
                    return InkWell(
                      onTap: () async {
                        if (ctrl.isDateFiltering == false) {
                          ctrl.dateFilteringState(true);
                          DateTimeRange? newDateRange =
                              await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025),
                            initialDateRange: ctrl.dateRange,
                          );
                          if (newDateRange != null) {
                            ctrl.filterByDateRange(newDateRange);
                          }
                        } else {
                          ctrl.dateFilteringState(false);
                        }
                      },
                      child: Icon(
                        ctrl.isDateFiltering == true
                            ? Icons.restart_alt
                            : Icons.filter_list,
                        color: CustomColors.appClr,
                      ),
                    );
                  }),
                  CustomWidth.widthFive(context),
                  GetBuilder<TransactionDbController>(builder: (ctrl) {
                    return InkWell(
                        onTap: () {
                          ctrl.toggleSortOrder();
                        },
                        child: Icon(
                          ctrl.isAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: CustomColors.appClr,
                        ));
                  }),
                  CustomWidth.widthFive(context),
                  InkWell(
                    onTap: () async {
                      await Get.to(() => const CategoryScreen(),
                          curve: Curves.easeOut,
                          transition: Transition.size,
                          duration: AppDuration.appDuration);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: CustomColors.appClr,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Statics',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.w500,
                            size: 13,
                            color: CustomColors.kwhite),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GetBuilder<TransactionDbController>(
          builder: (controller) {
            if (controller.transaction.isEmpty) {
              return emptyLottiePop(
                  messsage: 'No Transaction', screenSize: screenSize);
            }
            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final values = controller.isDateFiltering
                      ? controller.dateFilter[index]
                      : controller.transaction[index];
                  String date = DateFormat.MMMd().format(values.date);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TransactionFieldWidget(
                        screenSize: screenSize, values: values, date: date),
                  );
                },
                itemCount: controller.isDateFiltering
                    ? controller.dateFilter.length
                    : controller.transaction.length,
              ),
            );
          },
        )
      ],
    );
  }
}
