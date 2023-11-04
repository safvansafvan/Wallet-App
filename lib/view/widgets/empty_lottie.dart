import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management_app/controller/core/constant.dart';

Widget emptyLottiePop({required String messsage, required Size screenSize}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/animation/empty.json',
            height: screenSize.height * 0.35, width: screenSize.width * 0.35),
        Text(
          messsage,
          style: CustomFuction.style(fontWeight: FontWeight.w400, size: 15),
        ),
        Text(
          'Tap + Add One',
          style: CustomFuction.style(fontWeight: FontWeight.w400, size: 15),
        )
      ],
    ),
  );
}
