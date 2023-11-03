import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/category_model.dart';

const categoryDbName = 'category_db';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategorys();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteAllCategory();
  // Future<void> clearCategoryData();
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenceCategoryListNotifier =
      ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryBox.put(value.id, value);
    reloadUi();
  }

  @override
  Future<List<CategoryModel>> getCategorys() async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryBox.values.toList();
  }

  Future<void> reloadUi() async {
    final allCategory = await getCategorys();
    expenceCategoryListNotifier.value.clear();
    incomeCategoryListNotifier.value.clear();
    await Future.forEach(allCategory, (CategoryModel category) {
      // ignore: unrelated_type_equality_checks
      if (category.type == CategoryType.income) {
        incomeCategoryListNotifier.value.add(category);
      } else {
        expenceCategoryListNotifier.value.add(category);
      }
    });
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomeCategoryListNotifier.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expenceCategoryListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteAllCategory() async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryBox.clear();
    await categoryBox.close();
    log('deleted');
    reloadUi();
  }

  // @override
  // Future<void> clearCategoryData() async {
  //   await Hive.deleteBoxFromDisk(categoryDbName);
  //   final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
  //   await categoryBox.clear();
  // }
}
