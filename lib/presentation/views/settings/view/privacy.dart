import 'package:flutter/material.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class Privacy extends StatelessWidget {
  static const route = 'privacy';
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeights.minimumHeight(context),
              const Text('Last Update: 08/06/2024'),
              CustomHeights.minimumHeight(context),
              const Text(
                'This Privacy Policy explains how Walletwise ("we," "us," or "our") manages information in our Flutter money management app, Wallet App ("the App"). Please carefully review this Privacy Policy before using the App.',
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Information We Collect',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Walletwise does not collect or store any personal information, financial data, or personally identifiable information (PII). The App does not access your device\'s internet connection or external servers.',
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'How We Use Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'As Walletwise does not collect personal information or connect to the internet, we do not use your data for any purpose.',
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Data Security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'We implement reasonable measures to protect the App and any data it may contain. However, since we do not collect or store personal data, the risk associated with data breaches is minimal.',
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Third-Party Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Walletwise does not integrate with or use any third-party services, and it does not share any information with third parties.',
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Children\'s Privacy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Walletwise is not intended for children under the age of 13, and we do not knowingly collect information from children.',
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Changes to This Privacy Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'This Privacy Policy may be updated periodically to reflect changes in our practices or for other operational, legal, or regulatory reasons. The date at the beginning of this Privacy Policy will be updated to indicate the last revision date. Your continued use of the App after the revised Privacy Policy has been posted signifies your acceptance of the changes.',
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CustomHeights.minimumHeight(context),
              const Text(
                'If you have any questions or concerns regarding this Privacy Policy or Wallet , please contact us at ',
              ),
              const Text(
                'sajusajuptl@gmail.com',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
