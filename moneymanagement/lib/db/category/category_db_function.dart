import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/model/category/category_model.dart';

const Category_DB_Name = 'category_database';

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategory();
  Future<void> insertFunction(CategoryModel value);
  Future<void> deleteCategory(String CategoryID);
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB._internal() {
    // Initialize Hive listener for automatic updates
    _initHiveListener();
  }

  static final CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() => instance;

  final ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  // Hive box reference
  Box<CategoryModel>? _categoryBox;

  Future<Box<CategoryModel>> _getCategoryBox() async {
    _categoryBox ??= await Hive.openBox<CategoryModel>(Category_DB_Name);
    return _categoryBox!;
  }

  void _initHiveListener() {
    Hive.box<CategoryModel>(Category_DB_Name).listenable().addListener(refreshUI);
  }

  @override
  Future<void> insertFunction(CategoryModel value) async {
    try {
      final box = await _getCategoryBox();
      await box.put(value.id,value);
      // Don't need to call refreshUI here because the Hive listener will handle it
    } catch (e) {
      debugPrint('Error inserting category: $e');
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    try {
      final box = await _getCategoryBox();
      return box.values.toList();
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      return [];
    }
  }

  Future<void> refreshUI() async {
    try {
      final allCategories = await getCategory();
      
      // Create new lists to ensure ValueNotifier triggers updates
      final newIncomeList = <CategoryModel>[];
      final newExpenseList = <CategoryModel>[];

      for (final category in allCategories) {
        if (category.type == CategoryType.income) {
          newIncomeList.add(category);
        } else {
          newExpenseList.add(category);
        }
      }

      // Assign new lists (this triggers UI updates)
      incomeCategoryList.value = newIncomeList;
      expenseCategoryList.value = newExpenseList;
    } catch (e) {
      debugPrint('Error refreshing UI: $e');
    }
  }

  // Add this to properly close the box when done
  Future<void> close() async {
    await _categoryBox?.close();
    _categoryBox = null;
  }
  
  @override
  Future<void> deleteCategory(String CategoryID) async{
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    await  _categoryDB.delete(CategoryID);
    refreshUI();
  }
}