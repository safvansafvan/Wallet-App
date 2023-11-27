import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';
import 'package:money_management_app/model/category/category_model.dart';
import 'package:money_management_app/view/transaction/add_transaction/widget/select_date_button.dart';
import 'package:money_management_app/view/widgets/common_text_field.dart';

// ignore: must_be_immutable
class EditTransactionBody extends StatelessWidget {
  const EditTransactionBody(
      {super.key,
      required this.editAmountController,
      required this.editPurposeController,
      required this.globalKey});

  final TextEditingController editPurposeController;
  final TextEditingController editAmountController;
  final GlobalKey<FormState> globalKey;
  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryDbController());
    final globelController = Get.put(GlobelController());
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
              return Card(
                elevation: 5,
                child: SizedBox(
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
                ),
              );
            }),
          ],
        ),
        CustomHeights.heightFive(context),
        Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  Notes',
                style: CustomFuction.style(
                    fontWeight: FontWeight.w600,
                    size: 15,
                    color: CustomColors.kblack),
              ),
              CommonTextFormField(
                  screenSize: screenSize,
                  keyboardType: TextInputType.name,
                  controller: editPurposeController,
                  title: 'Purpose'),
              CustomHeights.heightFive(context),
              Text(
                '  Amount',
                style: CustomFuction.style(
                    fontWeight: FontWeight.w600,
                    size: 15,
                    color: CustomColors.kblack),
              ),
              CommonTextFormField(
                  screenSize: screenSize,
                  keyboardType: TextInputType.number,
                  controller: editAmountController,
                  title: 'Amount'),
            ],
          ),
        )
      ],
    );
  }
}
