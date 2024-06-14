import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/domain/model/category/category_model.dart';
import 'package:money_management_app/domain/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/presentation/controllers/globel_controller.dart';
import 'package:money_management_app/presentation/controllers/transaction_db_controller.dart';
import 'package:money_management_app/presentation/views/transaction/add_transaction/widget/select_date_button.dart';
import 'package:money_management_app/presentation/views/transaction/add_transaction/widget/text_form_fields_widget.dart';
import 'package:money_management_app/presentation/widgets/toast_msg.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

// ignore: must_be_immutable
class TransactionBody extends StatelessWidget {
  const TransactionBody({
    super.key,
    required this.purposeController,
    required this.amountController,
    required this.globalKey,
  });
  final TextEditingController purposeController;
  final TextEditingController amountController;
  final GlobalKey<FormState> globalKey;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final controller = Get.find<GlobelController>();
    final categoryController = Get.find<CategoryDbController>();
    return Column(
      children: [
        SelectDateButton(
          screenSize: screenSize,
          controller: controller,
          color: CustomColors.kblack,
        ),
        CustomHeights.commonheight(context),
        GetBuilder<GlobelController>(builder: (ctrl) {
          return SizedBox(
            height: screenSize.height * 0.084,
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  hint: const Text('Select Category'),
                  value: ctrl.selectIdDrop?.value,
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
                    controller.updateDropDownId(selectedVal!);
                  },
                ),
              ),
            ),
          );
        }),
        CustomHeights.heightFive(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextFormFieldsWidget(
              globalKey: globalKey,
              purposeController: purposeController,
              amountController: amountController),
        ),
        CustomHeights.heightFive(context),
        GetBuilder<GlobelController>(
          builder: (ctrl) {
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
                            controller.selectIdDrop = null;
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
                          value: CategoryType.expense,
                          groupValue: ctrl.selectedCategoryType,
                          onChanged: (value) {
                            ctrl.updateCategoryType(CategoryType.expense);
                            controller.selectIdDrop = null;
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
          },
        ),
        CustomHeights.minimumHeight(context),
        SizedBox(
          width: context.width - 50,
          child: ElevatedButton.icon(
              style: AppTheme.buttonStyle,
              onPressed: () async {
                if (globalKey.currentState!.validate()) {
                  addTrasnsaction(context);
                }
              },
              icon: const Icon(Icons.check),
              label: const Text('Confirm')),
        ),
      ],
    );
  }

  Future<void> addTrasnsaction(context) async {
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
    final amount = double.parse(amountController.text);
    final model = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        purpose: purposeController.text,
        amount: amount,
        date: globelController.selectedDate!,
        type: globelController.selectedCategoryType!,
        category: globelController.selectedCategoryModel!);
    await transactionController.insertTransaction(model);
    Navigator.pop(context);
  }
}
