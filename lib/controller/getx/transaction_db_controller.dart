import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:money_management_app/model/transaction.dart/transaction_model.dart';

const transactionDbName = 'transaction_db';

class TransactionDbController extends GetxController {
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

  Future<void> refreshTransaction() async {
    final list = await getAllTransactions();

    list.sort((first, second) => second.date.compareTo(first.date));

    transaction.clear();
    transactionFilter.clear();

    transaction.addAll(list);
    transactionFilter.addAll(list);

    update();
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(transactionDbName);
    return db.values.toList();
  }
}
