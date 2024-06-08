import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/config/theme.dart';
import 'package:money_management_app/domain/model/category/category_model.dart';
import 'package:money_management_app/presentation/controllers/category_db_controller.dart';
import 'package:money_management_app/utils/constant/color.dart';
import 'package:money_management_app/utils/constant/duration.dart';
import 'package:money_management_app/utils/resouces/res.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryPopUp(BuildContext context) async {
  final categoryController = Get.find<CategoryDbController>();
  final TextEditingController addCategoryController = TextEditingController();
  showAlignedDialog(
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    barrierColor: Colors.transparent,
    duration: AppDuration.appDuration,
    followerAnchor: Alignment.center,
    targetAnchor: Alignment.center,
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: CustomColors.kwhite,
      shadowColor: CustomColors.kblack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('Add Category'),
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: TextFormField(
            controller: addCategoryController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[400]!)),
              hintText: 'Category Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Radiobutton(title: 'Income', type: CategoryType.income),
              Radiobutton(title: 'Expence', type: CategoryType.expense)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ElevatedButton(
            style: AppTheme.buttonStyle,
            onPressed: () async {
              final name = addCategoryController.text;
              if (name.isEmpty) {
                return;
              }
              final type = selectedCategoryNotifier.value;
              final category = CategoryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  type: type);
              await categoryController.insertCategory(category);
              addCategoryController.text = '';
            },
            child: Text(
              'Add Category',
              style: CustomFuction.style(
                fontWeight: FontWeight.w500,
                size: 14,
                color: CustomColors.kwhite,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

class Radiobutton extends StatelessWidget {
  const Radiobutton({super.key, required this.title, required this.type});
  final String title;
  final CategoryType type;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ValueListenableBuilder(
        valueListenable: selectedCategoryNotifier,
        builder: (context, CategoryType newCategory, child) {
          return Radio<CategoryType>(
            value: type,
            groupValue: newCategory,
            onChanged: (value) {
              if (value == null) {
                return;
              }
              selectedCategoryNotifier.value = value;
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              selectedCategoryNotifier.notifyListeners();
            },
          );
        },
      ),
      Text(title)
    ]);
  }
}
