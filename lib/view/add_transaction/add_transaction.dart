import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/model/category/category_model.dart';
import 'package:money_management_app/model/transaction.dart/transaction_model.dart';
import 'package:money_management_app/view/add_transaction/widget/select_date_button.dart';
import 'package:money_management_app/view/add_transaction/widget/text_form_fields_widget.dart';
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

  String? selectIdDrop;
  @override
  void initState() {
    Get.put(GlobelController(), permanent: true).setDefultIncomeCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final controller = Get.put(GlobelController());
    final categoryController = Get.put(CategoryDbController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                          color: CustomColors.commonClr,
                        )),
                  ),
                  Text(
                    'Add Transactions',
                    style: CustomFuction.style(
                        fontWeight: FontWeight.w600,
                        size: 17,
                        color: CustomColors.commonClr),
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                        onPressed: () {
                          if (globalKey.currentState!.validate()) {
                            addTrasnsaction();
                          }
                        },
                        icon: Icon(Icons.check, color: CustomColors.commonClr)),
                  )
                ],
              ),
              CustomHeights.commonheight(context),
              SelectDateButton(screenSize: screenSize, controller: controller),
              CustomHeights.commonheight(context),
              GetBuilder<GlobelController>(builder: (ctrl) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: screenSize.width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: CustomColors.commonClr, width: 2)),
                      child: Row(
                        children: [
                          Radio(
                            value: CategoryType.income,
                            groupValue: ctrl.selectedCategoryType,
                            onChanged: (value) {
                              ctrl.updateCategoryType(CategoryType.income);
                              selectIdDrop = null;
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
                    Container(
                      width: screenSize.width * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: CustomColors.commonClr, width: 2)),
                      child: Row(
                        children: [
                          Radio(
                            value: CategoryType.expense,
                            groupValue: ctrl.selectedCategoryType,
                            onChanged: (value) {
                              ctrl.updateCategoryType(CategoryType.expense);
                              selectIdDrop = null;
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
                        color: CustomColors.commonClr),
                  ),
                  GetBuilder<GlobelController>(builder: (ctrl) {
                    return Container(
                      height: screenSize.height * 0.074,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CustomColors.commonClr, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            hint: const Text('Select Category'),
                            value: selectIdDrop,
                            items: (ctrl.selectedCategoryType ==
                                        CategoryType.income
                                    ? categoryController.incomeCategoryList
                                    : categoryController.expenceCategoryList)
                                .map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(e.name),
                                onTap: () {
                                  controller.selectedCategoryModel = e;
                                },
                              );
                            }).toList(),
                            onChanged: (selectedVal) {
                              setState(() {
                                selectIdDrop = selectedVal;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              CustomHeights.heightFive(context),
              TextFormFieldsWidget(
                  globalKey: globalKey,
                  purposeController: purposeController,
                  amountController: amountController),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTrasnsaction() async {
    final globelController = Get.put(GlobelController());
    final transactionController = Get.put(TransactionDbController());
    if (selectIdDrop == null) {
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
