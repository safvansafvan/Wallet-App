import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/db/category.dart';
import 'package:money_management_app/view/widgets/empty_lottie.dart';
import '../../../model/category_model.dart';

class IncomeTabBar extends StatelessWidget {
  const IncomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomeCategoryListNotifier,
        builder: (context, List<CategoryModel> newList, _) {
          if (CategoryDb.instance.incomeCategoryListNotifier.value.isEmpty) {
            return emptyLottiePop(
                messsage: 'No Income Category', screenSize: screenSize);
          } else {
            return ListView.builder(
                itemCount: newList.length,
                itemBuilder: (context, index) {
                  final category = newList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 60,
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
                            style: CustomFuction.style(
                                fontWeight: FontWeight.w600, size: 16),
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete_outline_outlined,
                              color: CustomColors.kred,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
