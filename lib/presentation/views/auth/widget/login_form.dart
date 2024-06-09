import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:money_management_app/presentation/controllers/auth_controller.dart';
import 'package:money_management_app/utils/constant/color.dart';

class LoginFrom extends StatelessWidget {
  const LoginFrom(
      {super.key,
      required this.label,
      required this.controller,
      required this.prefixIcon,
      this.inputType,
      this.isUsername = false,
      this.isPassword = false,
      this.isconformPassword = false,
      this.isname = false,
      this.isnumber = false});

  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final bool isUsername;
  final bool isname;
  final bool isconformPassword;
  final bool isnumber;

  final IconData prefixIcon;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthCtrl>(builder: (loginCtrl) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
        child: Center(
          child: TextFormField(
            inputFormatters: isnumber == true
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ]
                : [],
            keyboardType: inputType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            cursorColor: Colors.black,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            maxLengthEnforcement: MaxLengthEnforcement.none,
            decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon),
              suffixIcon: isPassword == true
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                        onPressed: () {
                          loginCtrl.passwordObx();
                        },
                        icon: Icon(
                          loginCtrl.isobx
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    )
                  : null,
              errorStyle: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 10, color: Colors.red),
              label: Text(label),
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: CustomColors.borderClr),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: CustomColors.borderClr),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            obscureText: isPassword == true ? loginCtrl.isobx : false,
            validator: (value) {
              if (isPassword) {
                if (value == null || value.isEmpty) {
                  return 'Enter Password';
                }
                if (value.length < 7) {
                  return 'Minimum 7 Letters';
                }
              }
              if (isUsername) {
                if (value == null || value.isEmpty) {
                  return 'Enter Email';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Enter Valid Email';
                }
              }
              if (isconformPassword) {
                if (value == null || value.isEmpty) {
                  return 'Enter Passwor';
                }
                if (value.length < 7) {
                  return 'Minimum 7 Letters';
                }
                if (loginCtrl.passwordCtrl.text !=
                    loginCtrl.conformpasswordCtrl.text) {
                  return 'Password Incorrect';
                }
              }
              if (isname) {
                if (value == null || value.isEmpty) {
                  return 'Enter Name';
                }
                if (value.length < 4) {
                  return 'Enter Valid Name';
                }
              }
              if (isnumber) {
                if (value == null || value.isEmpty) {
                  return 'Enter Name';
                }
                if (value.length != 10) {
                  return 'Enter Valid Number';
                }
              }

              return null;
            },
          ),
        ),
      );
    });
  }
}
