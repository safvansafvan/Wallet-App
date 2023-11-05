import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransationModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;

  TransationModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category});
}
