import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/presentation/controllers/globel_controller.dart';
import 'package:money_management_app/presentation/views/transaction/add_transaction/widget/transaction_body.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController purposeController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    final gc = Get.find<GlobelController>();
    gc.setDefultIncomeCategory();
    gc.selectIdDrop = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: TransactionBody(
              purposeController: purposeController,
              amountController: amountController,
              globalKey: globalKey),
        ),
      ),
    );
  }
}
