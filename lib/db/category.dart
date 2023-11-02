import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/category.dart';

const categoryDbName = 'category_db';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategorys();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDb implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryBox.add(value);
  }

  @override
  Future<List<CategoryModel>> getCategorys() async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryBox.values.toList();
  }
}
