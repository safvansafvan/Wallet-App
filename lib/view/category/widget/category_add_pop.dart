import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/db/category.dart';
import 'package:money_management_app/model/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryPopUp(BuildContext context) async {
  TextEditingController addCategoryController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('Add Category'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: TextFormField(
            controller: addCategoryController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: CustomColors.commonClr, width: 1.5)),
                hintText: 'Category Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Radiobutton(title: 'Income', type: CategoryType.income),
              Radiobutton(title: 'Expence', type: CategoryType.expense)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  final name = addCategoryController.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final type = selectedCategoryNotifier.value;
                  final category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: type);
                  CategoryDb.instance.insertCategory(category);
                  Navigator.of(context).pop();
                },
                child: const Text('Add'))
          ],
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
          }),
      Text(title)
    ]);
  }
}
