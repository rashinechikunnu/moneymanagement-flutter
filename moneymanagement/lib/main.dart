import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/model/category/category_model.dart';
import 'package:moneymanagement/screen/add_transaction/add_transaction_screen.dart';
import 'package:moneymanagement/screen/home/home_screen.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive with Flutter
    await Hive.initFlutter();

    // Register adapters (only if not already registered)
    if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
      Hive.registerAdapter(CategoryTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
      Hive.registerAdapter(CategoryModelAdapter());
    }

    // Open your Hive box before running the app
    await Hive.openBox<CategoryModel>('category_database');

    runApp(const MyApp());
  } catch (e) {
    debugPrint('Failed to initialize Hive: $e');
    // Consider showing an error screen or fallback UI
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Failed to initialize app: $e'),
          ),
        ),
      ),
    );
  }
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