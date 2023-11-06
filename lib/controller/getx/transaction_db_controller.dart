import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:money_management_app/model/category/category_model.dart';
import 'package:money_management_app/model/transaction.dart/transaction_model.dart';

const transactionDbName = 'transaction_db';

class TransactionDbController extends GetxController {
  RxDouble income = 0.0.obs;
  RxDouble expence = 0.0.obs;
  RxDouble balance = 0.0.obs;
  List<TransactionModel> transaction = [];
  List<TransactionModel> transactionFilter = [];
  Future<void> insertTransaction(TransactionModel value) async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(transactionDbName);
    await transactionBox.put(value.id, value);
    await refreshTransaction();
  }

  Future<List<TransactionModel>> getTransaction() async {
    final transactionBox =
        await Hive.openBox<TransactionModel>(transactionDbName);
    return transactionBox.values.toList();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    return db.values.toList();
  }

  Future<void> refreshTransaction() async {
    final list = await getAllTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    transaction.clear();
    transactionFilter.clear();
    transaction.addAll(list);
    transactionFilter.addAll(list);
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
  }
}
