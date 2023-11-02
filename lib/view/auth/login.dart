import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/auth/widget/header_widget.dart';
import 'package:money_management_app/view/auth/widget/login_options_widget.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomColors.kblack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomHeights.heightFive(context),
          const LoginHeaderWidget(),
          LoginOptionsWidget(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'By continuing,you are indicating that you accept our',
                  style: TextStyle(color: CustomColors.kwhite),
                ),
                RichText(
                    text: const TextSpan(
                  text: 'Terms Of Serivice And Privacy Policy',
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
