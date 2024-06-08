import 'package:flutter/material.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/domain/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class ViewTransactionBody extends StatelessWidget {
  const ViewTransactionBody({super.key, required this.object});

  final TransactionModel? object;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(object?.type.name.toUpperCase() ?? "",
                style: AppTheme.style2),
          ),
          const Divider(),
          RichText(
            text: TextSpan(
              text: 'DATE : ',
              style: AppTheme.style1,
              children: [
                TextSpan(text: object?.date.toString(), style: AppTheme.style2)
              ],
            ),
          ),
          CustomHeights.heightFive(context),
          RichText(
            text: TextSpan(
              text: 'CATEGORY : ',
              style: AppTheme.style1,
              children: [
                TextSpan(text: object?.category.name, style: AppTheme.style2)
              ],
            ),
          ),
          CustomHeights.heightFive(context),
          RichText(
            text: TextSpan(
              text: 'DESCRIPTION : ',
              style: AppTheme.style1,
              children: [
                TextSpan(text: object?.purpose ?? "", style: AppTheme.style2)
              ],
            ),
          ),
          CustomHeights.heightFive(context),
          RichText(
            text: TextSpan(
              text: 'Amount : ',
              style: AppTheme.style1,
              children: [
                TextSpan(
                    text: object?.amount.toString(), style: AppTheme.style2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
