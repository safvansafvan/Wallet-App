import 'package:flutter/material.dart';
import 'package:money_management_app/presentation/widgets/toast_msg.dart';
import 'package:money_management_app/utils/constant/color.dart';

class FeedbackTileWidget extends StatelessWidget {
  const FeedbackTileWidget(
      {super.key,
      required this.nameController,
      required this.screenSize,
      required this.hintText});

  final TextEditingController nameController;
  final Size screenSize;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.065,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        cursorColor: CustomColors.appClr,
        controller: nameController,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            messageToast('$hintText is empty');
          }
          return;
        },
      ),
    );
  }
}
