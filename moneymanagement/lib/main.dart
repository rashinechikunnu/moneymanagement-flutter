import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/model/category/category_model.dart';
import 'package:moneymanagement/model/transaction/transaction_model.dart';
import 'package:moneymanagement/screen/add_transaction/add_transaction_screen.dart';
import 'package:moneymanagement/screen/home/home_screen.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

    // Initialize Hive with Flutter
    await Hive.initFlutter();

    

    // Register adapters (only if not already registered)
    if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
      Hive.registerAdapter(CategoryTypeAdapter());
    }

    if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }

    if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
      Hive.registerAdapter(TransactionModelAdapter());
    }

    await Hive.openBox<CategoryModel>('category_database');
    await Hive.openBox<TransactionModel>('transaction_db');
  
    


    runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
      routes: {
        // '/add-transaction':(ctx)=>AddTransactionScreen(),
        AddTransactionScreen.routeName:(ctx)=>AddTransactionScreen(),
      },
    
    );
  }
}