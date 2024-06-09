import 'package:flutter/material.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/constant/duration.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class AppTheme {
  static FloatingActionButtonThemeData floatingActionButtonTheme =
      FloatingActionButtonThemeData(
    backgroundColor: CustomColors.appClr,
    elevation: 20,
    foregroundColor: CustomColors.kwhite,
    hoverElevation: 2,
    hoverColor: CustomColors.kgreen,
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: CustomColors.appClr,
    centerTitle: true,
    elevation: 0,
    foregroundColor: CustomColors.kwhite,
    titleTextStyle: CustomFuction.style(fontWeight: FontWeight.w600, size: 17),
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: CustomColors.appClr,
    foregroundColor: CustomColors.kwhite,
    animationDuration: AppDuration.appDuration,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static InputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: CustomColors.borderClr));

  static TextStyle style1 = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14, color: CustomColors.kblack);
  static TextStyle style2 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 14, color: CustomColors.kblack);
}
