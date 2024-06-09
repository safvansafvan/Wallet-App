import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/presentation/views/auth/auth.dart';
import 'package:money_management_app/presentation/views/home/home_screen.dart';
import 'package:money_management_app/presentation/widgets/toast_msg.dart';
import 'package:money_management_app/utils/constant/duration.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthCtrl extends GetxController {
  bool isLogin = false;
  bool isobx = true;
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;
  void loginState() {
    isLogin = !isLogin;
    update();
  }

  void passwordObx() {
    isobx = !isobx;
    update();
  }

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController conformpasswordCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController forgotEmailCtrl = TextEditingController();

  handleScreens(context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Get.off(() => const MyHomeScreen(),
          transition: Transition.zoom,
          curve: Curves.easeOut,
          duration: AppDuration.appDuration);
    } else {
      return Get.off(() => const LoginView(),
          transition: Transition.zoom,
          curve: Curves.easeOut,
          duration: AppDuration.appDuration);
    }
  }

// logout
  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await auth.signOut();
      await Get.offAll(() => const LoginView(),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          transition: Transition.zoom);
      messageToast('Logout');
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  ///*************************** singup with email and password *********************************
  bool isSignUpLoading = false;
  Future<void> signUpWithEmailAndPassword(BuildContext ctx) async {
    isSignUpLoading = true;
    update();
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: emailCtrl.text, password: passwordCtrl.text);
      if (credential.user != null) {
        clearController1();
        messageToast('SignUp');
        isSignUpLoading = false;
        update();
        return Get.off(() => const MyHomeScreen(),
            transition: Transition.zoom,
            curve: Curves.easeOut,
            duration: AppDuration.appDuration);
      } else {
        messageToast('Something Went Wrong');
      }
    } catch (e) {
      messageToast(e.toString());
      log(e.toString());
    }
    isSignUpLoading = false;
    update();
  }

//*********************************************signin with email and password *******************************************
  bool isSignInLoading = false;
  Future<void> signInWithEmailAndPasswords(BuildContext ctx) async {
    isSignInLoading = true;
    update();
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: emailCtrl.text, password: passwordCtrl.text);

      if (credential.user != null) {
        clearController();
        messageToast('Login');
        isSignInLoading = false;
        update();
        return await Get.offAll(() => const MyHomeScreen());
      } else {
        messageToast('Something Went Wrong');
      }
    } catch (e) {
      messageToast(e.toString());
      log(e.toString());
    }
    isSignInLoading = false;
    update();
  }

  clearController() {
    emailCtrl.clear();
    passwordCtrl.clear();
  }

  clearController1() {
    emailCtrl.clear();
    passwordCtrl.clear();
    conformpasswordCtrl.clear();
    nameCtrl.clear();
  }

  bool hasInternet = false;

  Future<void> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      hasInternet = false;
    } else {
      hasInternet = true;
    }
    update();
  }

  bool isForgotLoading = false;
  Future<void> forgotPassword(context) async {
    isForgotLoading = true;
    update();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotEmailCtrl.text)
          .then((value) {
        Navigator.pop(context);
        forgotEmailCtrl.clear();
        isForgotLoading = false;
        messageToast(
          'We have send you a email',
        );
        update();
      });
    } catch (e) {
      messageToast(
        e.toString(),
      );
      log(e.toString());
    } finally {
      isForgotLoading = false;
      update();
    }
  }
}
