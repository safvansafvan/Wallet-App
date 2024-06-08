import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management_app/presentation/controllers/auth_controller.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/presentation/controllers/transaction_db_controller.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    navigation(context);
    Get.find<CategoryDbController>().reloadUi();
    Get.find<TransactionDbController>().refreshTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'W A L L E T  A P P',
              style: CustomFuction.style(
                fontWeight: FontWeight.bold,
                size: 15,
                color: CustomColors.appClr,
              ),
            ),
            Lottie.asset('assets/animation/app_loading.json',
                height: 60, width: 60),
          ],
        ),
      ),
    );
  }

  Future<void> navigation(context) async {
    final ctrl = Get.find<AuthCtrl>();
    await Future.delayed(const Duration(seconds: 3), () {});
    ctrl.handleScreens(context);
  }
}
