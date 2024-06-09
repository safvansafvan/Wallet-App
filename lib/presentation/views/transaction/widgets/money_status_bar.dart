import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/presentation/controllers/transaction_db_controller.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class MoneyStatusBar extends StatelessWidget {
  const MoneyStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<TransactionDbController>();
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
            Column(
              children: [
                Text(
                  'Your Balance',
                  style: CustomFuction.style(
                      fontWeight: FontWeight.bold,
                      size: 14,
                      color: CustomColors.appClr),
                ),
                Text(
                  ' \$${transactionController.balance}',
                  style: CustomFuction.style(
                      fontWeight: FontWeight.bold, size: 18),
                ),
              ],
            ),
            Column(
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
          ],
        ),
      ),
    );
  }
}
