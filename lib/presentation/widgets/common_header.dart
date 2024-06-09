import 'package:flutter/material.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

Text commonHeader(String text) {
  return Text(
    text,
    style: CustomFuction.style(
      fontWeight: FontWeight.bold,
      size: 17,
      color: CustomColors.kblack,
    ),
  );
}
