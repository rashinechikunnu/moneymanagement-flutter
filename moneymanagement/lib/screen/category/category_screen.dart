import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db_function.dart';
import 'package:moneymanagement/screen/category/expense_category_list.dart';
import 'package:moneymanagement/screen/category/income_category_list.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with SingleTickerProviderStateMixin {
 late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "INCOME",),
            Tab(text: 'EXPENSE',),
          ]
          
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                IncomeCategoryList(),
                ExpenseCategoryList(),
              ]
              ),
              ),
      ],
        
    
    );
  }
}