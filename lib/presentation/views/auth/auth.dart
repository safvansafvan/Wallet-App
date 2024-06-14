import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/presentation/controllers/auth_controller.dart';
import 'package:money_management_app/presentation/views/auth/widget/login_wid.dart';
import 'package:money_management_app/presentation/views/auth/widget/singup_wid.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kwhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<AuthCtrl>(
            builder: (lCtrl) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          lCtrl.isLogin == false ? 'LOGIN' : 'SINGUP',
                          style: CustomFuction.style(
                              fontWeight: FontWeight.bold,
                              size: 26,
                              color: CustomColors.appClr),
                        ),
                      ),
                    ),
                    lCtrl.isLogin == false
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15)
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15),
                    lCtrl.isLogin == false
                        ? const LoginWidget()
                        : const SignUpWid(),
                    GestureDetector(
                      onTap: () {
                        lCtrl.loginState();
                        if (lCtrl.isLogin) {
                          lCtrl.clearController();
                        } else {
                          lCtrl.clearController1();
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          text: lCtrl.isLogin == false
                              ? "Don't have An Account ? "
                              : 'Have An Account ? ',
                          style: TextStyle(color: CustomColors.kgrey),
                          children: [
                            TextSpan(
                              text:
                                  lCtrl.isLogin == false ? 'Sign Up' : 'Login',
                              style: TextStyle(
                                  color: CustomColors.kblack,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
