import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db_function.dart';
import 'package:moneymanagement/model/category/category_model.dart';

ValueNotifier<CategoryType>selectedCategoryNotifier = ValueNotifier(CategoryType.income);


Future<void>ShowCategoryPopup(BuildContext context)async{
  final data_get = TextEditingController(); 
  showDialog(
    context: context, 
    builder: (ctx){
    return SimpleDialog(
      title: Text("Add category"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: data_get,
            decoration: InputDecoration(
              hintText: "category name",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            RadioButton(title: 'Income', type: CategoryType.income),
            RadioButton(title: 'expense', type: CategoryType.expense),
          ],
        ),
        
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: (){
            final name_data = data_get.text;
            if (name_data.isEmpty) {
              return;
            }
              final _type = selectedCategoryNotifier.value;
              final categoryy = CategoryModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: name_data, 
                type: _type
                );

                CategoryDB.instance.insertFunction(categoryy);
                Navigator.of(ctx).pop();

            
          }, 
          child: Text("Add",
          style:TextStyle(color: Colors.blue) ,),
          ),
        )
      ],
    );
  });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({super.key,
  required this.title,
  required this.type,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget?_){
           return Radio<CategoryType>(
          value: type,
          groupValue: newCategory,
          onChanged: (value){
            if (value == null) {
              return;
            }
           selectedCategoryNotifier.value= value;
           selectedCategoryNotifier.notifyListeners();
          },
          );
          }),
        Text(title)
      ],
    );
  }
}