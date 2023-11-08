import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/view/search/search_transaction.dart';
import 'widgets/transaction_field_widget.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/widgets/common_header.dart';
import 'package:money_management_app/view/widgets/empty_lottie.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/view/transaction/widgets/custom_cliper_shape.dart';
import 'package:money_management_app/view/transaction/widgets/money_status_bar.dart';

class TrasactionsScreen extends StatelessWidget {
  const TrasactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.put(TransactionDbController()).calculateIncomeAndExpence();
    });
    var screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.29,
            width: double.infinity,
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomClipperShape(),
                  child: Container(
                    height: screenSize.height * 0.26,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            CustomColors.commonClr,
                            CustomColors.gradientSecond
                          ]),
                    ),
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: Icon(Icons.menu_rounded,
                                color: CustomColors.kwhite),
                          ),
                          Text(
                            "WALLET APP",
                            style: CustomFuction.style(
                                fontWeight: FontWeight.w600,
                                size: 17,
                                color: CustomColors.kwhite),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchTransaction(),
                                  ));
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 25),
              child: commonHeader('Last Transations'),
            ),
          ),
          GetBuilder<TransactionDbController>(builder: (controller) {
            if (controller.transaction.isEmpty) {
              return emptyLottiePop(
                  messsage: 'No Transaction', screenSize: screenSize);
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final values = controller.transaction[index];
                String date = DateFormat.MMMd().format(values.date);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TransactionFieldWidget(
                      screenSize: screenSize, values: values, date: date),
                );
              },
              itemCount: controller.transaction.length,
            );
          })
        ],
      ),
    );
  }
}
