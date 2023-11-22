import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonTextFormField extends StatelessWidget {
  CommonTextFormField(
      {super.key,
      required this.controller,
      required this.title,
      required this.keyboardType,
      required this.screenSize,
      this.maxLength});

  final TextEditingController controller;
  final String title;
  final TextInputType keyboardType;
  int? maxLength;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: screenSize.height * 0.074,
        width: double.infinity,
        child: Center(
          child: TextFormField(
            controller: controller,
            maxLength: maxLength,
            maxLines: 1,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: title,
            ),
            keyboardType: keyboardType,
            validator: (value) {
              if (value!.isEmpty) {
                return "Required";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
