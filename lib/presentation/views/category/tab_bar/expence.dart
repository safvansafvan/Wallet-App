import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/presentation/views/category/widget/category_tile_widget.dart';
import '../../../widgets/empty_lottie.dart';

class ExpenceTabBar extends StatelessWidget {
  const ExpenceTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GetBuilder<CategoryDbController>(
      builder: (controller) {
        if (controller.expenceCategoryList.isEmpty) {
          return emptyLottiePop(
              messsage: 'No Expence Category', screenSize: screenSize);
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              final expence = controller.expenceCategoryList[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: categoryTileWidget(
                      screenSize: screenSize, category: expence));
            },
            itemCount: controller.expenceCategoryList.length,
          );
        }
      },
    );
  }
}
