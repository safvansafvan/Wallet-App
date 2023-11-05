import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';
import 'package:money_management_app/model/category/category_model.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = 'add_transation';
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String? selectIdDrop;
  @override
  void initState() {
    Get.put(GlobelController(), permanent: true).setDefultIncomeCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GlobelController());
    final categoryController = Get.put(CategoryDbController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  radius: 25,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: CustomColors.commonClr,
                      )),
                ),
              ),
              CustomHeights.heightFive(context),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: CustomColors.commonClr, width: 1.5)),
                    hintText: 'Purpose',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              CustomHeights.heightFive(context),
              TextFormField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: CustomColors.commonClr, width: 1.5)),
                    hintText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              TextButton.icon(
                onPressed: () async {
                  final selectedTempDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (selectedTempDate == null) {
                    return;
                  } else {
                    log(selectedTempDate.toString());
                    controller.updateDate(selectedTempDate);
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: GetBuilder<GlobelController>(builder: (ctrl) {
                  final formattedDate = DateFormat.MMMEd()
                      .format(ctrl.selectedDate ?? DateTime.now());
                  return Text(ctrl.selectedDate == null
                      ? 'Select Date'
                      : formattedDate);
                }),
              ),
              GetBuilder<GlobelController>(builder: (ctrl) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
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
                    Row(
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
                  ],
                );
              }),
              GetBuilder<GlobelController>(builder: (ctrl) {
                return DropdownButton<String>(
                  hint: const Text('Select Category'),
                  value: selectIdDrop,
                  items: (ctrl.selectedCategoryType == CategoryType.income
                          ? categoryController.incomeCategoryList
                          : categoryController.expenceCategoryList)
                      .map((e) {
                    return DropdownMenuItem(value: e.id, child: Text(e.name));
                  }).toList(),
                  onChanged: (selectedVal) {
                    setState(() {
                      selectIdDrop = selectedVal;
                    });
                  },
                );
              }),
              CustomHeights.heightFive(context),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
