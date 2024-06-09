import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/domain/model/category/category_model.dart';
import 'package:money_management_app/domain/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/presentation/controllers/globel_controller.dart';
import 'package:money_management_app/presentation/views/transaction/add_transaction/widget/select_date_button.dart';
import 'package:money_management_app/presentation/views/transaction/edit_transactions/edit_transactions.dart';
import 'package:money_management_app/presentation/widgets/common_text_field.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

// ignore: must_be_immutable
class EditTransactionBody extends StatefulWidget {
  const EditTransactionBody(
      {super.key,
      required this.object,
      required this.editAmountController,
      required this.editPurposeController,
      required this.globalKey});

  final TextEditingController editPurposeController;
  final TextEditingController editAmountController;
  final GlobalKey<FormState> globalKey;
  final TransactionModel? object;

  @override
  State<EditTransactionBody> createState() => _EditTransactionBodyState();
}

class _EditTransactionBodyState extends State<EditTransactionBody> {
  TextEditingController categoryCtrl = TextEditingController();
  @override
  void initState() {
    categoryCtrl.text = widget.object?.category.name ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globelController = Get.find<GlobelController>();
    var screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        SelectDateButton(
          screenSize: screenSize,
          controller: globelController,
          color: CustomColors.kblack,
        ),
        CustomHeights.commonheight(context),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            '!!The category is not changeable.!!',
            style: TextStyle(fontSize: 10),
          ),
        ),
        CommonTextFormField(
            screenSize: screenSize,
            isRead: true,
            keyboardType: TextInputType.number,
            controller: categoryCtrl,
            title: 'Category'),
        CustomHeights.heightFive(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: widget.globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextFormField(
                    screenSize: screenSize,
                    keyboardType: TextInputType.name,
                    controller: widget.editPurposeController,
                    title: 'Purpose'),
                CustomHeights.heightFive(context),
                CommonTextFormField(
                    screenSize: screenSize,
                    keyboardType: TextInputType.number,
                    controller: widget.editAmountController,
                    title: 'Amount'),
              ],
            ),
          ),
        ),
        CustomHeights.commonheight(context),
        GetBuilder<GlobelController>(builder: (ctrl) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                elevation: 5,
                child: SizedBox(
                  width: screenSize.width * 0.35,
                  child: Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: ctrl.selectedCategoryType,
                        onChanged: (value) {
                          ctrl.updateCategoryType(CategoryType.income);
                          globelController.selectIdDrop = null;
                        },
                      ),
                      Text(
                        'Income',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.w400, size: 15),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: SizedBox(
                  width: screenSize.width * 0.35,
                  child: Row(
                    children: [
                      Radio(
                        activeColor: CustomColors.appClr,
                        value: CategoryType.expense,
                        groupValue: ctrl.selectedCategoryType,
                        onChanged: (value) {
                          ctrl.updateCategoryType(CategoryType.expense);
                          globelController.selectIdDrop = null;
                        },
                      ),
                      Text(
                        'Expence',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.w400, size: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
        CustomHeights.commonheight(context),
        SizedBox(
          width: context.width - 50,
          child: ElevatedButton.icon(
            style: AppTheme.buttonStyle,
            onPressed: () async {
              if (widget.globalKey.currentState!.validate()) {
                EditTransactions().updateTransaction(context,
                    widget.editAmountController, widget.editPurposeController);
              }
            },
            icon: const Icon(Icons.check),
            label: const Text('Conform'),
          ),
        )
      ],
    );
  }
}
