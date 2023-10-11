import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/logo/applogo.png', width: 150),
        Center(
          child: Text(
            ' W a l l e t A p p ',
            style: CustomFuction.style(
              fontWeight: FontWeight.bold,
              size: 17,
              color: CustomColors.kwhite,
            ),
          ),
        ),
      ],
    );
  }
}
