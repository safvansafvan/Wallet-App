import 'package:flutter/material.dart';

class CustomHeights {
  static heightFive(context) {
    Size size = MediaQuery.of(context).size;
    var height = SizedBox(
      height: size.height * 0.01,
    );
    return height;
  }

  static minimumHeight(context) {
    Size size = MediaQuery.of(context).size;
    var height = SizedBox(
      height: size.height * 0.02,
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
      width: size.width * 0.04,
    );
    return width;
  }

  static commonWidth(context) {
    Size size = MediaQuery.of(context).size;
    var width = SizedBox(
      width: size.width * 0.03,
    );
    return width;
  }
}

class CustomFuction {
  static TextStyle style(
      {required FontWeight fontWeight, required double size, Color? color}) {
    return TextStyle(fontSize: size, fontWeight: fontWeight, color: color);
  }
}
