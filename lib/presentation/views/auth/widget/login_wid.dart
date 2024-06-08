import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/presentation/controllers/auth_controller.dart';
import 'package:money_management_app/presentation/views/auth/widget/forgot.dart';
import 'package:money_management_app/presentation/views/auth/widget/login_form.dart';
import 'package:money_management_app/presentation/widgets/toast_msg.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final lCtrl = Get.find<AuthCtrl>();
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoginFrom(
                  label: 'Email',
                  prefixIcon: Icons.email,
                  controller: lCtrl.emailCtrl,
                  inputType: TextInputType.name,
                  isUsername: true,
                ),
                LoginFrom(
                  label: 'Password',
                  prefixIcon: Icons.key,
                  controller: lCtrl.passwordCtrl,
                  inputType: TextInputType.name,
                  isPassword: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      forgotPasswordDialog(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text('Forgot password ?'),
                    ),
                  ),
                ),
                GetBuilder<AuthCtrl>(
                  builder: (ctrl) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: ctrl.isSignInLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: AppTheme.buttonStyle,
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await ctrl.checkInternet();
                                    if (ctrl.hasInternet) {
                                      await ctrl.signInWithEmailAndPasswords(
                                          // ignore: use_build_context_synchronously
                                          context);
                                    } else {
                                      messageToast('Internet is required');
                                    }
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'LOGIN',
                                    style: CustomFuction.style(
                                        fontWeight: FontWeight.w600,
                                        size: 16,
                                        color: CustomColors.kwhite),
                                  ),
                                ),
                              ),
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
