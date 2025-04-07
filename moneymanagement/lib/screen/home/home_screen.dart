import 'package:flutter/material.dart';
import 'package:moneymanagement/screen/add_transaction/add_transaction_screen.dart';
import 'package:moneymanagement/screen/category/Popup_category.dart';
import 'package:moneymanagement/screen/category/category_screen.dart';
import 'package:moneymanagement/screen/home/widget/bottomnavigation.dart';
import 'package:moneymanagement/transaction/transaction_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  static  ValueNotifier<int>selectedIndexNotifier = ValueNotifier(0);

  final pages = [
    TransactionScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Management"),
        backgroundColor:Colors.green,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomnavigationScreen(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, _){
            return pages[updateIndex];
          }),
      ),
        
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),),
      
      onPressed: (){
        if (selectedIndexNotifier.value == 0) {
          // Navigator.pushNamed(context, '/add-transaction');
          Navigator.of(context).pushNamed(AddTransactionScreen.routeName);
        }else{
          ShowCategoryPopup(context);
        }
      },
      child: Icon(Icons.add,) ,
      ),
    );
  }
}