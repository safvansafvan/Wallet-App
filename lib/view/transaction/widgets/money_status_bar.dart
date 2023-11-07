import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';

class MoneyStatusBar extends StatelessWidget {
  const MoneyStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.put(TransactionDbController());
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        height: 170,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.blue,
                spreadRadius: -4.0,
                blurRadius: 10.0,
              )
            ]),
        child: Column(
          children: [
            Text(
              'Your Balance',
              style: CustomFuction.style(
                  fontWeight: FontWeight.bold,
                  size: 14,
                  color: CustomColors.commonClr),
            ),
            Text(
              ' \$${transactionController.balance}',
              style: CustomFuction.style(fontWeight: FontWeight.bold, size: 18),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: CustomColors.kblue.withAlpha(100))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Income',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.bold, size: 14),
                      ),
                      Text(
                        '\$${transactionController.income}',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.bold,
                            size: 18,
                            color: CustomColors.kgreen),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        'Expences',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.bold, size: 14),
                      ),
                      Text(
                        '\$${transactionController.expence}',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.bold,
                            size: 18,
                            color: CustomColors.kred),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
