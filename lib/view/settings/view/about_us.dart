import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';

class AboutUs extends StatelessWidget {
  static const route = 'about';
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
            preferredSize: Size(double.infinity, 0), child: Divider()),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: Text(
          'About Us',
          style: CustomFuction.style(
              fontWeight: FontWeight.w600,
              size: 17,
              color: CustomColors.kblack),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wallet App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Developed By Muhammed Safvan',
                style: TextStyle(fontStyle: FontStyle.italic)),
            Text('Version : 1.0.0'),
          ],
        ),
      ),
    );
  }
}
