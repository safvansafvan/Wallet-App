import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';

void snakBarWidget(context, String msg, Color clr) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(msg, style: TextStyle(color: CustomColors.kwhite, fontSize: 15)),
      backgroundColor: clr,
      elevation: 13));
}
