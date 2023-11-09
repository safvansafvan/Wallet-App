import 'package:flutter/material.dart';
import 'package:money_management_app/view/widgets/toast_msg.dart';

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
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
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
