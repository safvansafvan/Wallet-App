import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';
import 'package:money_management_app/model/category/category_model.dart';
import 'package:money_management_app/view/transaction/add_transaction/widget/select_date_button.dart';
import 'package:money_management_app/view/transaction/add_transaction/widget/text_form_fields_widget.dart';

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
    final controller = Get.put(GlobelController());
    final categoryController = Get.put(CategoryDbController());
    return Column(
      children: [
        SelectDateButton(
          screenSize: screenSize,
          controller: controller,
          color: CustomColors.kblack,
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
        CustomHeights.commonheight(context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '  Select Category',
              style: CustomFuction.style(
                  fontWeight: FontWeight.w600,
                  size: 15,
                  color: CustomColors.kblack),
            ),
            GetBuilder<GlobelController>(builder: (ctrl) {
              return SizedBox(
                height: screenSize.height * 0.084,
                width: double.infinity,
                child: Card(
                  elevation: 5,
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
                ),
              );
            })
          ],
        ),
        CustomHeights.heightFive(context),
        TextFormFieldsWidget(
            globalKey: globalKey,
            purposeController: purposeController,
            amountController: amountController),
      ],
    );
  }
}
