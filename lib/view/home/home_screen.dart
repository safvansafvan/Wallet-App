import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/add_transaction/add_transaction.dart';
import 'package:money_management_app/view/category/category.dart';
import 'package:money_management_app/view/category/widget/category_add_pop.dart';
import 'package:money_management_app/view/home/widgets/bottom_navigation.dart';
import 'package:money_management_app/view/transaction/transactions.dart';

// ignore: must_be_immutable
class MyHomeScreen extends StatelessWidget {
  MyHomeScreen({super.key});

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);

  List pages = const [TrasactionsScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, updatedInd, _) {
          return pages[updatedInd];
        },
      ),
      bottomNavigationBar: const BottomNavigation(),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: CustomColors.commonClr,
        tooltip: "Add",
        elevation: 20,
        child: Icon(
          Icons.add,
          color: CustomColors.kwhite,
        ),
        onPressed: () {
          if (selectedIndex.value == 0) {
            Navigator.of(context).pushNamed(AddTransaction.routeName);
            log('trasations');
          } else {
            log('categories');
            showCategoryPopUp(context);
          }
        },
      ),
    );
  }
}
