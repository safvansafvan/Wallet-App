import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/domain/model/category/category_model.dart';
import 'package:money_management_app/domain/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/presentation/controllers/globel_controller.dart';
import 'package:money_management_app/presentation/views/transaction/add_transaction/widget/select_date_button.dart';
import 'package:money_management_app/presentation/views/transaction/edit_transactions/edit_transactions.dart';
import 'package:money_management_app/presentation/widgets/common_text_field.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

// ignore: must_be_immutable
class EditTransactionBody extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryDbController>();
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
        GetBuilder<GlobelController>(builder: (ctrl) {
          return SizedBox(
            height: screenSize.height * 0.074,
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  hint: const Text('Select Category'),
                  value: globelController.selectIdDrop?.value,
                  items: (ctrl.selectedCategoryType == CategoryType.income
                          ? categoryController.incomeCategoryList
                          : categoryController.expenceCategoryList)
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id.toString(),
                      child: Text(e.name),
                      onTap: () async {
                        await categoryController.reloadUi();
                        ctrl.selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedVal) {
                    globelController.updateDropDownId(selectedVal!);
                  },
                ),
              ),
            ),
          );
        }),
        CustomHeights.heightFive(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextFormField(
                    screenSize: screenSize,
                    keyboardType: TextInputType.name,
                    controller: editPurposeController,
                    title: 'Purpose'),
                CustomHeights.heightFive(context),
                CommonTextFormField(
                    screenSize: screenSize,
                    keyboardType: TextInputType.number,
                    controller: editAmountController,
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
              if (globalKey.currentState!.validate()) {
                EditTransactions().updateTransaction(
                    context, editAmountController, editPurposeController);
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
