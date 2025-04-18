import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/db/category/category_db_function.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/model/category/category_model.dart';
import 'package:moneymanagement/model/transaction/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();

    return ValueListenableBuilder(
     valueListenable: TransactionDb.instance.TransactionNotifier,
     builder: (BuildContext ctx, List<TransactionModel>NewList, Widget?_){
      return ListView.separated(
      padding: EdgeInsets.all(10),
      // values
      itemBuilder: (ctx,index){
        final _value = NewList[index];
        return Slidable(
          key: Key(_value.id!),
          startActionPane: ActionPane(
            motion: ScrollMotion(), 
            children: [
              SlidableAction(
                onPressed: (ctx){
                  TransactionDb.instance.deleteTransaction(_value.id!);
                },
                icon:Icons.delete,
                label: 'Delete',
                )
            ]),
          child: Card(
           elevation: 0,
           child: ListTile(
             leading: CircleAvatar(
               radius: 30,
               backgroundColor: _value.type == CategoryType.income
               ? Colors.green
               :Colors.red,
               foregroundColor: Colors.white,
               child: Text(
                 parsDate(_value.date),
               textAlign: TextAlign.center,),
               ),
             title: Text("Rs ${_value.amount}"),
             subtitle: Text(_value.category.name),
           ),
                    ),
        );
      },
      separatorBuilder: (ctx,index){
        return SizedBox(height: 10,);
      }, 
      itemCount: NewList.length,
      );
     });
    
  }
  String parsDate(DateTime date)
  {

    final _date = DateFormat.MMMd().format(date);
    final _splitedDate =_date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';


    // return DateFormat.MMMd().format(date);

    // return '${date.day}\n${date.month}';
  }
}