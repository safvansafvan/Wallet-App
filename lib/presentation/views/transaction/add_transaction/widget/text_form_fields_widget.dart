import 'package:flutter/material.dart';
import 'package:money_management_app/presentation/widgets/common_text_field.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class TextFormFieldsWidget extends StatelessWidget {
  const TextFormFieldsWidget(
      {super.key,
      required this.globalKey,
      required this.purposeController,
      required this.amountController});

  final GlobalKey<FormState> globalKey;
  final TextEditingController purposeController;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Form(
      key: globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextFormField(
              screenSize: screenSize,
              maxLength: 100,
              keyboardType: TextInputType.name,
              controller: purposeController,
              title: 'Description'),
          CustomHeights.heightFive(context),
          CommonTextFormField(
              screenSize: screenSize,
              maxLength: 6,
              keyboardType: TextInputType.number,
              controller: amountController,
              title: 'Amount'),
        ],
      ),
    );
  }
}
