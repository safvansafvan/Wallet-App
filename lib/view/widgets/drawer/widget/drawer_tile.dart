import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/db/category.dart';

class DrawerTileWidget extends StatelessWidget {
  const DrawerTileWidget({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (text == 'Clear Datas') {
          await CategoryDb.instance.clearCategoryData();
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.containerColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CustomColors.commonClr),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [Icon(icon), CustomWidth.widthFive(context), Text(text)],
          ),
        ),
      ),
    );
  }
}
