import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/presentation/widgets/empty_lottie.dart';

import '../widget/category_tile_widget.dart';

class IncomeTabBar extends StatelessWidget {
  const IncomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GetBuilder<CategoryDbController>(
      builder: (controller) {
        if (controller.incomeCategoryList.isEmpty) {
          return emptyLottiePop(
              messsage: 'No Income Category', screenSize: screenSize);
        } else {
          return ListView.builder(
            itemCount: controller.incomeCategoryList.length,
            itemBuilder: (context, index) {
              final category = controller.incomeCategoryList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: categoryTileWidget(
                    screenSize: screenSize, category: category),
              );
            },
          );
        }
      },
    );
  }
}
