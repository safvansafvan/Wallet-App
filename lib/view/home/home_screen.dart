import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/category/category.dart';
import 'package:money_management_app/view/home/widgets/bottom_navigation.dart';
import 'package:money_management_app/view/home/widgets/drawer.dart';
import 'package:money_management_app/view/transaction/transactions.dart';

// ignore: must_be_immutable
class MyHomeScreen extends StatelessWidget {
  MyHomeScreen({super.key});

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  List pages = const [TrasactionsScreen(), CategoryScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, updatedInd, _) {
          return pages[updatedInd];
        },
      )),
      drawer: const DrawerWidget(),
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
            log('trasations');
          } else {
            log('categories');
          }
        },
      ),
    );
  }
}
