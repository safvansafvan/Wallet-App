import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/globel_controller.dart';
import 'package:money_management_app/db/category.dart';
import 'package:money_management_app/model/category_model.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = 'add_transation';
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  void initState() {
    Get.put(GlobelController(), permanent: true).setDefultIncomeCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GlobelController(), permanent: true);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
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
                  return Text(ctrl.selectedDate == null
                      ? 'Select Date'
                      : controller.selectedDate.toString());
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
                return DropdownButton(
                  hint: const Text('Select Category'),
                  items: (ctrl.selectedCategoryType == CategoryType.income
                          ? CategoryDb().incomeCategoryListNotifier
                          : CategoryDb().expenceCategoryListNotifier)
                      .value
                      .map((e) {
                    return DropdownMenuItem(value: e.id, child: Text(e.name));
                  }).toList(),
                  onChanged: (value) {},
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
