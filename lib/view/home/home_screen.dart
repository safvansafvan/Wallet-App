import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/view/add_transaction/add_transaction.dart';
import 'package:money_management_app/view/category/category.dart';
import 'package:money_management_app/view/category/widget/category_add_pop.dart';
import 'package:money_management_app/view/home/widgets/bottom_navigation.dart';
import 'package:money_management_app/view/transaction/transactions.dart';

// ignore: must_be_immutable
class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    Get.put(CategoryDbController()).reloadUi();
    Get.put(TransactionDbController()).refreshTransaction();
    super.initState();
  }

  List pages = const [TrasactionsScreen(), CategoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: MyHomeScreen.selectedIndex,
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
          if (MyHomeScreen.selectedIndex.value == 0) {
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
