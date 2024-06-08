import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/domain/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/presentation/controllers/globel_controller.dart';
import 'package:money_management_app/presentation/controllers/transaction_db_controller.dart';
import 'package:money_management_app/presentation/views/transaction/edit_transactions/widget/edit_body.dart';
import 'package:money_management_app/presentation/widgets/toast_msg.dart';

// ignore: must_be_immutable
class EditTransactions extends StatelessWidget {
  EditTransactions({super.key, this.object});

  final TransactionModel? object;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final globelController = Get.find<GlobelController>();
    globelController.selectedCategoryType = object?.type;
    globelController.selectedCategoryModel = object?.category;
    globelController.selectedDate = object?.date;
    TextEditingController editPurposeController =
        TextEditingController(text: object?.purpose);
    TextEditingController editAmountController =
        TextEditingController(text: object?.amount.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Transaction'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: EditTransactionBody(
                  object: object,
                  editAmountController: editAmountController,
                  editPurposeController: editPurposeController,
                  globalKey: globalKey),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateTransaction(
      context,
      TextEditingController editAmountController,
      TextEditingController editPurposeController) async {
    final globelController = Get.find<GlobelController>();
    final transactionController = Get.find<TransactionDbController>();
    if (globelController.selectIdDrop == null) {
      return messageToast('Category Is Required');
    }
    if (globelController.selectedCategoryModel == null) {
      return messageToast('Select Income Or Expence');
    }
    if (globelController.selectedDate == null) {
      return messageToast('Date Is Required');
    }
    final amount = double.tryParse(editAmountController.text);
    final model = TransactionModel(
        id: object?.id ?? '',
        purpose: editPurposeController.text,
        amount: amount ?? 0.0,
        date: globelController.selectedDate!,
        type: globelController.selectedCategoryType!,
        category: globelController.selectedCategoryModel!);
    await transactionController.editTransaction(model);
    Navigator.pop(context);
  }
}
