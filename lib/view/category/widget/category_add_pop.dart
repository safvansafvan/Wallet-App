import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/model/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryPopUp(BuildContext context) async {
  final categoryController = Get.put(CategoryDbController());
  final TextEditingController addCategoryController = TextEditingController();
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
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text('Add')),
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
