import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/widgets/common_text_field.dart';

class TextFormFieldsWidget extends StatelessWidget {
  const TextFormFieldsWidget({
    super.key,
    required this.globalKey,
    required this.purposeController,
    required this.amountController,
  });

  final GlobalKey<FormState> globalKey;
  final TextEditingController purposeController;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '  Notes',
            style: CustomFuction.style(
                fontWeight: FontWeight.w600,
                size: 15,
                color: CustomColors.commonClr),
          ),
          CommonTextFormField(
              keyboardType: TextInputType.name,
              amountController: purposeController,
              title: 'Purpose'),
          CustomHeights.heightFive(context),
          Text(
            '  Amount',
            style: CustomFuction.style(
                fontWeight: FontWeight.w600,
                size: 15,
                color: CustomColors.commonClr),
          ),
          CommonTextFormField(
              keyboardType: TextInputType.number,
              amountController: amountController,
              title: 'Amount'),
        ],
      ),
    );
  }
}
