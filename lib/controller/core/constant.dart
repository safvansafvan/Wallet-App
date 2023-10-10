import 'package:flutter/material.dart';

class CustomFuction {
  static TextStyle style(
      {required FontWeight fontWeight, required double size, Color? color}) {
    return TextStyle(fontSize: size, fontWeight: fontWeight, color: color);
  }
}

class CustomColors {
  static Color kblue = Colors.blue;
  static Color kwhite = Colors.white;
  static Color kwhiteText = Colors.white70;
  static Color kgreen = Colors.green;
  static Color kred = Colors.red;
  static Color kblack = Colors.black;
  static Color kgrey = Colors.grey;
  static Color commonClr = const Color.fromRGBO(141, 32, 225, 1);
  static Color gradientSecond = const Color.fromRGBO(180, 48, 224, 1);
  static Color containerColor = const Color.fromARGB(160, 255, 255, 255);
}

class CustomHeights {
  static heightFive(context) {
    Size size = MediaQuery.of(context).size;
    var height = SizedBox(
      height: size.height * 0.01,
    );
    return height;
  }

  static commonheight(context) {
    Size size = MediaQuery.of(context).size;
    var height = SizedBox(
      height: size.height * 0.03,
    );
    return height;
  }
}

class CustomWidth {
  static widthFive(context) {
    Size size = MediaQuery.of(context).size;
    var width = SizedBox(
      width: size.width * 0.01,
    );
    return width;
  }
}
