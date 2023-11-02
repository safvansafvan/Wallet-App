import 'package:flutter/material.dart';
import 'package:money_management_app/model/category.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryPopUp(BuildContext context) async {
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
            decoration: InputDecoration(
                hintText: 'Category Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ))),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Radiobutton(title: 'Income', type: CategoryType.income),
              Radiobutton(title: 'Expence', type: CategoryType.expence)
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
                onPressed: () => Navigator.of(context).pop(),
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
    return ValueListenableBuilder(
        valueListenable: selectedCategoryNotifier,
        builder: (context, CategoryType newCategory, child) {
          return Row(
            children: [
              Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  selectedCategoryNotifier.value = value!;
                  selectedCategoryNotifier.notifyListeners();
                },
              ),
              Text(title)
            ],
          );
        });
  }
}
