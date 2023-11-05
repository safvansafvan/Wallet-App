import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/view/category/tab_bar/expence.dart';
import 'package:money_management_app/view/category/tab_bar/income.dart';

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
    final categoryController = Get.put(CategoryDbController());
    categoryController.reloadUi();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: CustomColors.commonClr,
          leading: IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: CustomColors.kwhite,
              )),
          title: Text(
            'STATICS',
            style: CustomFuction.style(
                fontWeight: FontWeight.w600,
                size: 17,
                color: CustomColors.kwhite),
          ),
          centerTitle: true,
        ),
        ColoredBox(
          color: CustomColors.commonClr,
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
              children: const [IncomeTabBar(), ExpenceTabBar()]),
        )
      ],
    );
  }
}
