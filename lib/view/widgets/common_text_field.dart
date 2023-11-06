import 'package:flutter/material.dart';
import '../../controller/core/constant.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField(
      {super.key,
      required this.amountController,
      required this.title,
      required this.keyboardType});

  final TextEditingController amountController;
  final String title;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: amountController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: CustomColors.commonClr, width: 1.5)),
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        }
        return null;
      },
    );
  }
}
