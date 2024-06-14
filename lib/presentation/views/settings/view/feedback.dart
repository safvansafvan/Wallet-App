import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/presentation/controllers/auth_controller.dart';
import 'package:money_management_app/presentation/views/settings/view/widget/feedback_tile.dart';
import 'package:money_management_app/presentation/widgets/toast_msg.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

// ignore: must_be_immutable
class FeedbackS extends StatelessWidget {
  FeedbackS({super.key});
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Our Team'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Column(
                children: [
                  FeedbackTileWidget(
                      nameController: nameController,
                      screenSize: screenSize,
                      hintText: 'Name'),
                  CustomHeights.commonheight(context),
                  FeedbackTileWidget(
                      nameController: emailController,
                      screenSize: screenSize,
                      hintText: 'Email'),
                  CustomHeights.commonheight(context),
                  FeedbackTileWidget(
                      nameController: subjectController,
                      screenSize: screenSize,
                      hintText: 'Subject'),
                  CustomHeights.commonheight(context),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      cursorColor: CustomColors.appClr,
                      controller: contentController,
                      maxLength: null,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Content',
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          messageToast('Content is empty');
                        }
                        return;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomHeights.commonheight(context),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
                style: AppTheme.buttonStyle,
                onPressed: () async {
                  if (globalKey.currentState!.validate()) {
                    await conformButtonClick(context);
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text('Confirm')),
          ),
        ],
      ),
    );
  }

  Future<void> conformButtonClick(ctx) async {
    final internetController = Get.find<AuthCtrl>();
    await internetController.checkInternet();

    if (nameController.text.isEmpty) {
      return;
    }
    if (emailController.text.isEmpty) {
      return;
    }
    if (contentController.text.isEmpty) {
      return;
    }
    if (subjectController.text.isEmpty) {
      return;
    }
    if (internetController.hasInternet == false) {
      messageToast('Enable Internet');
    } else {
      await feedbackSent(ctx: ctx);
      clearControllers();
    }
  }

  Future<void> feedbackSent({required BuildContext ctx}) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      final respose = await http.post(url,
          body: json.encode({
            'service_id': 'service_6vebo7n',
            'template_id': 'template_92ap2mn',
            'user_id': 'JcCWgw-cYY-WPW2tL',
            "template_params": {
              "user_name": nameController.text,
              "user_subject": subjectController.text,
              "user_message": contentController.text,
              "user_email": emailController.text
            }
          }),
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json'
          });
      if (respose.statusCode == 200 || respose.statusCode == 201) {
        messageToast('Feedback is Sented');
      } else {
        messageToast('somthing went wrong');
        log(respose.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    contentController.clear();
  }
}
