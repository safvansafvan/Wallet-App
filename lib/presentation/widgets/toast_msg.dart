import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void messageToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    fontSize: 16.0,
    timeInSecForIosWeb: 3,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
  );
}
