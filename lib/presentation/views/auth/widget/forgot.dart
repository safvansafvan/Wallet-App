import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/presentation/controllers/auth_controller.dart';
import 'package:money_management_app/presentation/views/auth/widget/login_form.dart';
import 'package:money_management_app/presentation/widgets/toast_msg.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/constant/duration.dart';
import 'package:money_management_app/utils/resouces/res.dart';

void forgotPasswordDialog(BuildContext context) {
  final ctrl = Get.find<AuthCtrl>();

  showAlignedDialog(
    barrierDismissible: false,
    duration: AppDuration.appDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: CustomColors.kwhite,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Forgot Password',
              style: CustomFuction.style(fontWeight: FontWeight.w600, size: 17),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: CustomColors.kblack),
            )
          ],
        ),
        content: GetBuilder<AuthCtrl>(
          builder: (loginC) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginFrom(
                  label: 'Email',
                  prefixIcon: Icons.email,
                  controller: loginC.forgotEmailCtrl,
                  inputType: TextInputType.name,
                  isUsername: true,
                ),
                const SizedBox(height: 20),
                loginC.isForgotLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: AppTheme.buttonStyle,
                        onPressed: () async {
                          if (ctrl.forgotEmailCtrl.text.isEmpty) {
                            messageToast(
                              'Enter Required Field',
                            );
                          } else {
                            await ctrl.forgotPassword(context);
                          }
                        },
                        child: const Text('   Reset  ')),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      );
    },
  );
}
