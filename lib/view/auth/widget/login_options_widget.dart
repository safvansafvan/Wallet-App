import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';

class LoginOptionsWidget extends StatelessWidget {
  const LoginOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
}
