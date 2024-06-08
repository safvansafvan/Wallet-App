import 'package:flutter/material.dart';
import 'package:money_management_app/domain/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/presentation/views/transaction/view_transaction/widget/view_transaction.dart';

class ViewTransaction extends StatelessWidget {
  const ViewTransaction({super.key, this.object});

  final TransactionModel? object;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ViewTransactionBody(object: object),
            ),
          ),
        ),
      ),
    );
  }
}
