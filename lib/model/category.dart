import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(1)
  income,
  @HiveField(2)
  expence,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final String type;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.type,
      this.isDeleted = false});
}
