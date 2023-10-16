import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/auth/widget/header_widget.dart';
import 'package:money_management_app/view/auth/widget/login_options_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kblack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomHeights.heightFive(context),
            const LoginHeaderWidget(),
            const LoginOptionsWidget(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Text(
                    'By continuing,you are indicating that you accept our',
                    style: TextStyle(color: CustomColors.kwhite),
                  ),
                  Row(
                    children: [
                      Text(
                        'Terms Of Serivice',
                        style: TextStyle(color: CustomColors.commonClr),
                      ),
                      Text(
                        ' and ',
                        style: TextStyle(color: CustomColors.kwhite),
                      ),
                      Text('Privacy Policy',
                          style: TextStyle(color: CustomColors.commonClr))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
