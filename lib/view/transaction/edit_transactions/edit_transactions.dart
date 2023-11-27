import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/view/transaction/edit_transactions/widget/edit_body.dart';
import 'package:money_management_app/view/widgets/snack_bar.dart';

// ignore: must_be_immutable
class EditTransactions extends StatelessWidget {
  EditTransactions({super.key, required this.object});

  final TransactionModel object;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final globelController = Get.put(GlobelController());
    globelController.selectedCategoryType = object.type;
    globelController.selectedCategoryModel = object.category;
    globelController.selectedDate = object.date;
    TextEditingController editPurposeController =
        TextEditingController(text: object.purpose);
    TextEditingController editAmountController =
        TextEditingController(text: object.amount.toString());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: CustomColors.kblack,
                          )),
                    ),
                    Text(
                      'Update Transaction',
                      style: CustomFuction.style(
                          fontWeight: FontWeight.w600,
                          size: 17,
                          color: CustomColors.kblack),
                    ),
                    CircleAvatar(
                      radius: 25,
                      child: IconButton(
                          onPressed: () async {
                            if (globalKey.currentState!.validate()) {
                              await updateTransaction(context,
                                  editAmountController, editPurposeController);
                            }
                          },
                          icon: Icon(Icons.check, color: CustomColors.kblack)),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: EditTransactionBody(
                        editAmountController: editAmountController,
                        editPurposeController: editPurposeController,
                        globalKey: globalKey)),
              ],
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
    final globelController = Get.put(GlobelController());
    final transactionController = Get.put(TransactionDbController());
    if (globelController.selectIdDrop == null) {
      return snakBarWidget(context, 'Category Is Required', CustomColors.kred);
    }
    if (globelController.selectedCategoryModel == null) {
      return snakBarWidget(
          context, 'Select Income Or Expence', CustomColors.kred);
    }
    if (globelController.selectedDate == null) {
      return snakBarWidget(context, 'Date Is Required', CustomColors.kred);
    }
    final amount = double.tryParse(editAmountController.text);
    final model = TransactionModel(
        id: object.id,
        purpose: editPurposeController.text,
        amount: amount ?? 0.0,
        date: globelController.selectedDate!,
        type: globelController.selectedCategoryType!,
        category: globelController.selectedCategoryModel!);
    await transactionController.insertTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
