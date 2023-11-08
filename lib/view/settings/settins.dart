import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/settings/widget/settings_tile_widget.dart';

class Settings extends StatelessWidget {
  static const routeName = 'settings';
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: Text(
          'Settings',
          style: CustomFuction.style(
              fontWeight: FontWeight.w600,
              size: 20,
              color: CustomColors.kblack),
        ),
        bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 0), child: Divider()),
      ),
      body: Column(
        children: [
          SettingsTileWidget(
              icon: Icons.feedback_outlined,
              text: 'Feedback',
              isFeedback: true),
          SettingsTileWidget(
              icon: Icons.account_balance_wallet_outlined,
              text: 'About us',
              isAboutus: true),
          SettingsTileWidget(
              icon: Icons.privacy_tip_outlined,
              text: 'Privacy',
              isPrivacy: true),
          SettingsTileWidget(
              icon: Icons.share_outlined, text: 'Share', isShare: true),
          SettingsTileWidget(
              icon: Icons.restore, text: 'Reset App', resetApp: true),
          const Spacer(),
          RichText(
            text: TextSpan(
              text: 'Version : ',
              style: TextStyle(fontSize: 17, color: CustomColors.commonClr),
              children: const <TextSpan>[
                TextSpan(
                    text: '1.0.0',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
