import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db_function.dart';
import 'package:moneymanagement/model/category/category_model.dart';

class AddTransactionScreen extends StatefulWidget {

  static const routeName = "add-transaction";
  
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {

  DateTime ? selectedDate;
  CategoryType ? selectedCategorytype;
  CategoryModel ? selectedCategoryModel;  
  String ? _categoryID;


  @override
  void initState() {
    selectedCategorytype =CategoryType.income;
    super.initState();
  }

 /*
 Purpose
 Amount
 Date
 income/expense
 categoryType
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // purpose
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(border: OutlineInputBorder(),
                hintText: 'Purpose',
                  ),
              ),
              SizedBox(height: 10,),
              // amount
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(),
                hintText: 'Amount'
                ),
              ),
              
              // calender
          
               TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: ()async{
                  final selectedDateTemp = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now()
                    );
                    if (selectedDateTemp == null) {
                      return;
                    }else{
                      setState(() {
                        selectedDate = selectedDateTemp;
                      });
                    }
                },
               icon: Icon(Icons.calendar_today),
               label: Text(selectedDate == null ? "Select Date" : selectedDate.toString()),
               ),
            
              //  income and expense
               Row(
                 children: [
                   Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: selectedCategorytype,
                        onChanged: (newValue){
                          setState(() {
                            selectedCategorytype = CategoryType.income;
                            _categoryID = null;
                          });
                        }
                        ),
                        Text("income")
                    ],
                   ),
                   Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: selectedCategorytype, 
                        onChanged: (newValue){
                          setState(() {
                            selectedCategorytype = CategoryType.expense;
                            _categoryID = null;
                          });
                          
                        }
                        ),
                        Text("expense")
                    ],
                   ),
                 ],
               ),

              //  categorytype
              DropdownButton(
                hint: Text("Select Categories"),
                value: _categoryID,
                items:(selectedCategorytype ==CategoryType.income
                ?CategoryDB().incomeCategoryList 
                : CategoryDB().expenseCategoryList)
                .value.
                map((e){
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name)
                  );
              }).toList(),
               onChanged: (selectedValue){
                setState(() {
                  _categoryID = selectedValue;
                });
               
               }
               ),
              //  submit button
              ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: (){}, 
              label: Text("Submit"))
               
            ],),
        ) 
      ),
    );
  }
}