import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/model/transaction.dart/transaction_model.dart';

class TransactionSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<TransactionModel> searchList = [];

  void searchTransaction(String query) {
    List<TransactionModel> result = [];
    final tController = Get.put(TransactionDbController());
    if (query.isEmpty) {
      result = tController.transaction;
      searchList = result;
      update();
    } else {
      result = tController.transaction
          .where((element) => element.purpose
              .toLowerCase()
              .trim()
              .startsWith(query.toLowerCase().trim()))
          .toList();
      searchList = result;
      update();
    }
  }

  void clearFieldText() {
    final tController = Get.put(TransactionDbController());
    searchController.clear();
    searchList = tController.transaction;
    update();
  }

  void initialValues() {
    final tController = Get.put(TransactionDbController());
    searchList = tController.transaction;
    update();
  }
}
