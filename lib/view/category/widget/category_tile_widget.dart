import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/model/category/category_model.dart';

import '../../../controller/core/constant.dart';

// ignore: camel_case_types
class categoryTileWidget extends StatelessWidget {
  const categoryTileWidget(
      {super.key, required this.screenSize, required this.category});

  final Size screenSize;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryDbController());
    return Container(
      height: screenSize.height * 0.08,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: CustomColors.containerColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CustomColors.kblue.withAlpha(100),
        ),
        boxShadow: [
          BoxShadow(color: CustomColors.kblue),
        ],
      ),
      child: Center(
        child: ListTile(
          title: Text(
            category.name,
            style: CustomFuction.style(fontWeight: FontWeight.w600, size: 16),
          ),
          trailing: IconButton(
            onPressed: () async {
              await categoryController.remove(category.id);
            },
            icon: Icon(
              Icons.delete_outline_outlined,
              color: CustomColors.kred,
            ),
          ),
        ),
      ),
    );
  }
}
