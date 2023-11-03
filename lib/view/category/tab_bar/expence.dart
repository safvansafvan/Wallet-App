import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/db/category.dart';
import '../../../model/category_model.dart';

class ExpenceTabBar extends StatelessWidget {
  const ExpenceTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenceCategoryListNotifier,
      builder: (context, List<CategoryModel> newList, _) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final expence = newList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: CustomColors.containerColor,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: CustomColors.kblue.withAlpha(100)),
                    boxShadow: [BoxShadow(color: CustomColors.kblue)]),
                child: Center(
                  child: ListTile(
                    title: Text(
                      expence.name,
                      style: CustomFuction.style(
                          fontWeight: FontWeight.w600, size: 16),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_outline_outlined,
                          color: CustomColors.kred,
                        )),
                  ),
                ),
              ),
            );
          },
          itemCount: newList.length,
        );
      },
    );
  }
}
