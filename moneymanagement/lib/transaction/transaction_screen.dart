import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx,index){
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            radius: 30,
            child: Text("25 march",textAlign: TextAlign.center,)),
          title: Text("30000"),
          subtitle: Text("Travel"),
        );
      },
      separatorBuilder: (ctx,index){
        return SizedBox(height: 10,);
      }, 
      itemCount: 10,
      );
  }
}