import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/login_controller.dart';
import 'package:money_management_app/view/auth/login.dart';
import 'package:money_management_app/view/home/home_screen.dart';

class ScrennLoadingScreen extends StatefulWidget {
  const ScrennLoadingScreen({super.key});

  @override
  State<ScrennLoadingScreen> createState() => _ScrennLoadingScreenState();
}

class _ScrennLoadingScreenState extends State<ScrennLoadingScreen> {
  @override
  void initState() {
    super.initState();
    navigation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.commonClr,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo/applogo.png',
                        height: 150, width: 150),
                    Text(
                      'W A L L E T  A P P',
                      style: CustomFuction.style(
                        fontWeight: FontWeight.bold,
                        size: 15,
                        color: CustomColors.kwhite,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Lottie.asset('assets/animation/app_loading.json',
                      height: 50, width: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigation(context) async {
    final controller = Get.put(LoginController());

    await Future.delayed(const Duration(seconds: 3), () {});
    controller.isSignedIn.value == false
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()))
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomeScreen()));
  }
}
