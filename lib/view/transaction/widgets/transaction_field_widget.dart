import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import '../../../model/category/category_model.dart';
import '../../../model/transaction.dart/transaction_model.dart';

class TransactionFieldWidget extends StatelessWidget {
  const TransactionFieldWidget({
    super.key,
    required this.screenSize,
    required this.values,
    required this.date,
  });

  final Size screenSize;
  final TransactionModel values;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenSize.height * 0.1,
        padding: const EdgeInsets.all(7),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: CustomColors.containerColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: CustomColors.kblue.withAlpha(100)),
            boxShadow: [BoxShadow(color: CustomColors.kblue)]),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: values.type == CategoryType.income
                  ? CustomColors.kgreen
                  : CustomColors.kred,
              radius: 30,
              child: Text(
                date,
                style: TextStyle(color: CustomColors.kwhite),
              ),
            ),
            title: Text(
              '\$${values.amount}',
              style: CustomFuction.style(fontWeight: FontWeight.w600, size: 18),
            ),
            subtitle: Text(
              values.purpose,
              style: CustomFuction.style(fontWeight: FontWeight.w500, size: 15),
            ),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ),
        ));
  }
}
