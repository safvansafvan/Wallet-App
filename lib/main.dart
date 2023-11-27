import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/category/category_model.dart';
import 'package:money_management_app/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/view/transaction/add_transaction/add_transaction.dart';
import 'package:money_management_app/view/settings/settins.dart';
import 'package:money_management_app/view/settings/view/about_us.dart';
import 'package:money_management_app/view/settings/view/feedback.dart';
import 'package:money_management_app/view/settings/view/privacy.dart';
import 'package:money_management_app/view/splash/screen_loding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MoneyManagement',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily),
      debugShowCheckedModeBanner: false,
      home: const ScrennLoadingScreen(),
      routes: {
        AddTransaction.routeName: (ctx) => const AddTransaction(),
        Settings.routeName: (ctx) => const Settings(),
        Privacy.route: (ctx) => const Privacy(),
        AboutUs.route: (ctx) => const AboutUs(),
        FeedbackS.route: (ctx) => FeedbackS()
      },
    );
  }
}
