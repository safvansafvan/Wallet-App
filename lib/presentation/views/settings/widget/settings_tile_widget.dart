import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/presentation/controllers/auth_controller.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/presentation/controllers/transaction_db_controller.dart';
import 'package:money_management_app/presentation/views/settings/view/about_us.dart';
import 'package:money_management_app/presentation/views/settings/view/feedback.dart';
import 'package:money_management_app/presentation/views/settings/view/privacy.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/constant/duration.dart';
import 'package:money_management_app/utils/resouces/res.dart';

import 'package:share/share.dart';

// ignore: must_be_immutable
class SettingsTileWidget extends StatelessWidget {
  SettingsTileWidget(
      {super.key,
      required this.icon,
      required this.text,
      this.isFeedback = false,
      this.isAboutus = false,
      this.logout = false,
      this.privacy = false,
      this.isShare = false,
      this.resetApp = false});
  final IconData icon;
  final String text;
  bool? isFeedback;
  bool? logout;
  bool? privacy;
  bool isAboutus;
  bool? isShare;
  bool? resetApp;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isFeedback == true) {
          await Get.to(() => FeedbackS(),
              transition: Transition.zoom,
              curve: Curves.easeOut,
              duration: AppDuration.appDuration);
        } else if (isShare == true) {
          shareApp();
        } else if (resetApp == true) {
          await restAppDialog(context);
        } else if (logout == true) {
          await Get.find<AuthCtrl>().logout(context);
        } else if (privacy == true) {
          await Get.to(() => const Privacy(),
              transition: Transition.zoom,
              curve: Curves.easeOut,
              duration: AppDuration.appDuration);
        } else if (isAboutus == true) {
          await Get.to(() => const AboutUs(),
              transition: Transition.zoom,
              curve: Curves.easeOut,
              duration: AppDuration.appDuration);
        }
      },
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: CustomColors.containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(icon),
              CustomWidth.widthFive(context),
              Text(
                text,
                style:
                    CustomFuction.style(fontWeight: FontWeight.w600, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> restAppDialog(ctx) async {
    showAlignedDialog(
      followerAnchor: Alignment.center,
      targetAnchor: Alignment.center,
      barrierColor: Colors.transparent,
      duration: AppDuration.appDuration,
      context: ctx,
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      builder: (context) {
        return SimpleDialog(
          backgroundColor: CustomColors.kwhite,
          shadowColor: CustomColors.kblack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(25),
          children: [
            Text(
              'Do You Want To Delete All App Data',
              style: CustomFuction.style(
                  color: Colors.red, fontWeight: FontWeight.w600, size: 16),
            ),
            CustomHeights.heightFive(context),
            ElevatedButton.icon(
              style: AppTheme.buttonStyle,
              onPressed: () async {
                await resetApplication();
                Get.back();
              },
              icon: const Icon(Icons.restore),
              label: const Text('Reset'),
            )
          ],
        );
      },
    );
  }

  Future<void> resetApplication() async {
    final tController = Get.find<TransactionDbController>();
    final cController = Get.find<CategoryDbController>();
    await cController.removeAllCategory();
    await tController.removeAllTransactions();
  }

  Future<void> shareApp() async {
    await Share.share('https://www.amazon.com/gp/product/B0CLKW1ZZJ');
  }
}
