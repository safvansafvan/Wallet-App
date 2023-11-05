import 'package:get/get.dart';
import 'package:money_management_app/model/category/category_model.dart';

class GlobelController extends GetxController {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;

  void updateDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void setDefultIncomeCategory() {
    selectedCategoryType = CategoryType.income;
  }

  void updateCategoryType(CategoryType value) {
    selectedCategoryType = value;
    update();
  }
}
