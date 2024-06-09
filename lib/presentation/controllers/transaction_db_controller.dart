import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/domain/model/transaction.dart/transaction_model.dart';
import '../../domain/model/category/category_model.dart';

const transactionDbName = 'transaction_db';

class TransactionDbController extends GetxController {
  RxDouble income = 0.0.obs;
  RxDouble expence = 0.0.obs;
  RxDouble balance = 0.0.obs;
  List<TransactionModel> transaction = [];
  List<TransactionModel> dateFilter = [];
  bool isAscending = true;
  bool isDateFiltering = false;

  void dateFilteringState(bool v) {
    isDateFiltering = v;
    update();
  }

  void toggleSortOrder() {
    isAscending = !isAscending;
    sortTransactions();
    update();
  }

  void sortTransactions() {
    transaction.sort((a, b) =>
        isAscending ? a.date.compareTo(b.date) : b.date.compareTo(a.date));
  }

  DateTimeRange? dateRange;

  void filterByDateRange(DateTimeRange range) {
    dateRange = range;
    dateFilter = transaction.where((tx) {
      return tx.date.isAfter(range.start) && tx.date.isBefore(range.end);
    }).toList();
    update();
  }

  Future<void> insertTransaction(TransactionModel value) async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(transactionDbName);
    await transactionBox.put(value.id, value);
    await refreshTransaction();
  }

  Future<List<TransactionModel>> getTransactions() async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(transactionDbName);
    return transactionBox.values.toList();
  }

  Future<void> remove(String id) async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionBox.delete(id);
    await refreshTransaction();
  }

  Future<void> refreshTransaction() async {
    final list = await getTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    transaction.clear();
    transaction.addAll(list);
    calculateIncomeAndExpence();
    update();
  }

  void calculateIncomeAndExpence() {
    income.value = 0.0;
    expence.value = 0.0;
    balance.value = 0.0;
    final List<TransactionModel> values = transaction;
    for (var i = 0; i < values.length; i++) {
      if (CategoryType.income == values[i].category.type) {
        income.value += values[i].amount;
      } else {
        expence.value += values[i].amount;
      }
    }
    balance.value = income.value - expence.value;
    update();
  }

  Future<void> editTransaction(TransactionModel value) async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(transactionDbName);
    await transactionBox.put(value.id, value);
    await refreshTransaction();
  }

  Future<void> removeAllTransactions() async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(transactionDbName);
    await transactionBox.clear();
    await transactionBox.close();
    await refreshTransaction();
  }
}
