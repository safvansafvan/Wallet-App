import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/internet_controller.dart';
import 'package:money_management_app/controller/getx/login_controller.dart';
import 'package:money_management_app/view/widgets/snack_bar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginOptionsWidget extends StatelessWidget {
  LoginOptionsWidget({super.key});
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => handleGoogleSignIn(context),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: CustomColors.commonClr),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/google_logo.png',
                  width: 25,
                  height: 25,
                ),
                CustomWidth.commonWidth(context),
                Text(
                  'Continue With Google',
                  style: CustomFuction.style(
                      fontWeight: FontWeight.w600,
                      size: 15,
                      color: CustomColors.kwhite),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.commonClr),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo/facebook_logo.png',
                  width: 25, height: 25),
              CustomWidth.commonWidth(context),
              Text(
                'Continue With Google',
                style: CustomFuction.style(
                    fontWeight: FontWeight.w600,
                    size: 15,
                    color: CustomColors.kwhite),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.commonClr),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo/instagram_logo.png',
                  width: 25, height: 25),
              CustomWidth.commonWidth(context),
              Text(
                'Continue With Google',
                style: CustomFuction.style(
                    fontWeight: FontWeight.w600,
                    size: 15,
                    color: CustomColors.kwhite),
              )
            ],
          ),
        )
      ],
    );
  }

  Future<void> handleGoogleSignIn(context) async {
    final internet = Get.put(InternetController());
    final signIn = Get.put(LoginController());
    if (internet.hasInternet.value == false) {
      snakBarWidget(context, "Enable Internet Connection", CustomColors.kblue);
      googleController.reset();
    } else {
      await signIn.signInWithGoogle().then((value) {
        if (signIn.hasError.value == true) {
          snakBarWidget(
              context, signIn.errorCode.toString(), CustomColors.kred);
          googleController.reset();
        } else {
          signIn.userExist().then((value) {
            if (value == true) {
            } else {}
          });
        }
      });
    }
  }
}
