import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/category/category_model.dart';

const categoryDbName = 'category_db';

class CategoryDbController extends GetxController {
  List<CategoryModel> incomeCategoryList = [];
  List<CategoryModel> expenceCategoryList = [];
  CategoryModel? categoryModel;

  Future<void> insertCategory(CategoryModel value) async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryBox.put(value.id, value);
    reloadUi();
  }

  Future<List<CategoryModel>> getCategorys() async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryBox.values.toList();
  }

  Future<void> reloadUi() async {
    final allCategory = await getCategorys();
    incomeCategoryList.clear();
    expenceCategoryList.clear();
    await Future.forEach(allCategory, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryList.add(category);
        update();
      } else {
        expenceCategoryList.add(category);
        update();
      }
    });
  }

  Future<void> remove(String id) async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    categoryBox.delete(id);
    await reloadUi();
  }

  Future<void> removeAllCategory() async {
    final categoryBox = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryBox.clear();
    await categoryBox.close();
    reloadUi();
  }
}
