import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/view/settings/view/about_us.dart';
import 'package:money_management_app/view/settings/view/privacy.dart';
import 'package:share/share.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';

// ignore: must_be_immutable
class SettingsTileWidget extends StatelessWidget {
  SettingsTileWidget(
      {super.key,
      required this.icon,
      required this.text,
      this.isAboutus = false,
      this.isFeedback = false,
      this.isPrivacy = false,
      this.isShare = false,
      this.resetApp = false});
  final IconData icon;
  final String text;
  bool? isFeedback;
  bool? isAboutus;
  bool? isPrivacy;
  bool? isShare;
  bool? resetApp;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isFeedback == true) {
        } else if (isAboutus == true) {
          Navigator.pushNamed(context, AboutUs.route);
        } else if (isPrivacy == true) {
          Navigator.pushNamed(context, Privacy.route);
        } else if (isShare == true) {
          shareApp('com.example');
        } else if (resetApp == true) {
          await restAppDialog(context);
        }
      },
      child: Container(
        height: 55,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: BoxDecoration(
          color: CustomColors.containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CustomColors.commonClr),
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
    showDialog(
      context: ctx,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(25),
          backgroundColor: Colors.red,
          children: [
            Text(
              'Do You Want To Delete All App Data',
              style: CustomFuction.style(
                  color: CustomColors.kwhite,
                  fontWeight: FontWeight.w600,
                  size: 16),
            ),
            CustomHeights.heightFive(context),
            ElevatedButton.icon(
              onPressed: () async {
                await resetApplication();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
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
    final tController = Get.put(TransactionDbController());
    final cController = Get.put(CategoryDbController());
    await cController.removeAllCategory();
    await tController.removeAllTransactions();
  }

  Future<void> shareApp(String shareText) async {
    await Share.share(shareText);
  }
}
