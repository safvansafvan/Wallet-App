import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/presentation/views/transaction/add_transaction/add_transaction.dart';
import 'package:money_management_app/presentation/views/transaction/transactions.dart';
import 'package:money_management_app/utils/constant/duration.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TransactionHomeView(),
      floatingActionButton: FloatingActionButton.small(
        tooltip: "Add",
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.to(() => const AddTransaction(),
              transition: Transition.zoom,
              curve: Curves.easeOut,
              duration: AppDuration.appDuration);
        },
      ),
    );
  }
}
