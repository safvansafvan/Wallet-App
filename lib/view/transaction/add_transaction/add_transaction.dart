import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/view/transaction/add_transaction/widget/transaction_body.dart';
import 'package:money_management_app/view/widgets/snack_bar.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = 'add_transation';
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
    Get.put(GlobelController(), permanent: true).setDefultIncomeCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                      'Add Transactions',
                      style: CustomFuction.style(
                          fontWeight: FontWeight.w600,
                          size: 17,
                          color: CustomColors.kblack),
                    ),
                    CircleAvatar(
                      radius: 25,
                      child: IconButton(
                          onPressed: () {
                            if (globalKey.currentState!.validate()) {
                              addTrasnsaction();
                            }
                          },
                          icon: Icon(Icons.check, color: CustomColors.kblack)),
                    )
                  ],
                ),
                CustomHeights.commonheight(context),
                TransactionBody(
                    purposeController: purposeController,
                    amountController: amountController,
                    globalKey: globalKey)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTrasnsaction() async {
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
    final amount = double.parse(amountController.text);
    final model = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        purpose: purposeController.text,
        amount: amount,
        date: globelController.selectedDate!,
        type: globelController.selectedCategoryType!,
        category: globelController.selectedCategoryModel!);
    await transactionController.insertTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
