import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const route = 'about';
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wallet App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Developed By Muhammed Safvan',
                style: TextStyle(fontStyle: FontStyle.italic)),
            Text('Version : 1.0.1'),
          ],
        ),
      ),
    );
  }
}
