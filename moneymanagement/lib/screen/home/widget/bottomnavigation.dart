import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement/screen/home/home_screen.dart';

class BottomnavigationScreen extends StatelessWidget {
  const BottomnavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx,int updateIndex,Widget?_){
        return BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: CupertinoColors.inactiveGray,
        currentIndex: updateIndex,
        onTap: (newIndex){
          HomeScreen.selectedIndexNotifier.value = newIndex;
        },
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,),
          label: ('Transactions'),  
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: ('Category'),
        )
      ],
      );
      },
      
    );
  }
}