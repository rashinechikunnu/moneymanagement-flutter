import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/model/transaction/transaction_model.dart';

const Transaction_db_name = 'transaction_db';

abstract class TransactionDbFunction {
  Future <void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>>getAllTransaction();
  Future<void>deleteTransaction(String id);

}

class TransactionDb implements TransactionDbFunction {

  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  
  factory TransactionDb(){
    return instance;
  }

  ValueNotifier<List<TransactionModel>>TransactionNotifier = ValueNotifier([]);



  @override
  Future<void> addTransaction(TransactionModel obj) async{
    
     final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
     await _db.put(obj.id, obj);
  }

  Future<void>refresh()async{
    final _list = await getAllTransaction();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    TransactionNotifier.value.clear();
    TransactionNotifier.value.addAll(_list);
    TransactionNotifier.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getAllTransaction()async{
    final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
    return _db.values.toList();
  }
  
  @override
  Future<void> deleteTransaction(String id)async {
    final _db = await Hive.openBox<TransactionModel>(Transaction_db_name);
    await _db.delete(id);
    refresh();
  }

}