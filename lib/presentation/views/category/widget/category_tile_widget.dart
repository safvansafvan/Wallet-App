import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/domain/model/category/category_model.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/resouces/res.dart';

// ignore: camel_case_types
class categoryTileWidget extends StatelessWidget {
  const categoryTileWidget(
      {super.key, required this.screenSize, required this.category});

  final Size screenSize;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDbController>(
      builder: (ctrl) {
        return Container(
          height: screenSize.height * 0.08,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: ListTile(
              title: Text(
                category.name,
                style:
                    CustomFuction.style(fontWeight: FontWeight.w600, size: 16),
              ),
              trailing: IconButton(
                onPressed: () async {
                  await ctrl.remove(category.id);
                },
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: CustomColors.kred,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
