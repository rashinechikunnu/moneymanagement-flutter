import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/model/category/category_model.dart';

@HiveType(typeId: 3)
class TransactionModel {
  final String purpose;
  final double amount;
  final DateTime datte;
  final CategoryType type;
  final CategoryModel category;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.datte,
    required this.type,
    required this.category,
  });
}
