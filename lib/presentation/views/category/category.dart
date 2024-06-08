import 'package:flutter/material.dart';
import 'package:money_management_app/presentation/views/category/tab_bar/expence.dart';
import 'package:money_management_app/presentation/views/category/tab_bar/income.dart';
import 'package:money_management_app/presentation/views/category/widget/category_add_pop.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('STATICS')),
      body: Column(
        children: [
          ColoredBox(
            color: CustomColors.appClr,
            child: TabBar(
              controller: controller,
              indicatorColor: CustomColors.kwhite,
              labelColor: CustomColors.kwhite,
              unselectedLabelColor: CustomColors.kwhite,
              labelStyle:
                  CustomFuction.style(fontWeight: FontWeight.bold, size: 16),
              tabs: const [
                Tab(text: 'Income'),
                Tab(text: 'Expence'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                IncomeTabBar(),
                ExpenceTabBar(),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: "Add",
        child: const Icon(Icons.add),
        onPressed: () {
          showCategoryPopUp(context);
        },
      ),
    );
  }
}
