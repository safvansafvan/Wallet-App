import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/model/category_model.dart';

class AddTransaction extends StatelessWidget {
  static const routeName = 'add_transation';
  const AddTransaction({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Select Date')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: CategoryType.income,
                        onChanged: (value) {},
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
                        value: CategoryType.income,
                        groupValue: CategoryType.income,
                        onChanged: (value) {},
                      ),
                      Text(
                        'Income',
                        style: CustomFuction.style(
                            fontWeight: FontWeight.w400, size: 15),
                      )
                    ],
                  ),
                ],
              ),
              DropdownButton(
                items: [],
                onChanged: (value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
