import 'package:expense_tracker/models/expnse_model.dart';
import 'package:flutter/material.dart';
class NewExpense extends StatefulWidget{
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}
class _NewExpenseState extends State<NewExpense>{
  var _enteredTitle = ' ';
  final _titleController  = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectDate;
  Category selectCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1,now.month,now.day);
    final _pickedDate = await showDatePicker(
        context: context,
        initialDate:now,
        firstDate: firstDate,
        lastDate:now
    );
    setState(() {
      _selectDate = _pickedDate;
    });
  }

  void _submitExpenseData(){
    final _enteredAmmount = double.tryParse(_amountController.text);
    final _ammountIsInvalid = _enteredAmmount == null || _enteredAmmount <= 0;
    if(_titleController.text.trim().isEmpty || _ammountIsInvalid || _selectDate == null){

      showDialog(context: context, builder:(ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please make sure a valid title, ammount ,date and category was entered'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          )
        ],
      ));
      return;
    }
    widget.onAddExpense(
      ExpenseModel(
          title: _titleController.text,
          amount: _enteredAmmount,
          date:_selectDate! ,
          category: selectCategory),);
    Navigator.pop(context);

  }

  @override
  void dispose(){
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveInputTitle(String inputValue){
    _enteredTitle = inputValue;
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              maxLength:50,
              decoration:const InputDecoration(
                label:Text('Title'),
              ),
            ),
          ),

          Row(children:[
            Expanded(child:TextField(
              controller:_amountController,
              keyboardType:TextInputType.number,
              decoration:const InputDecoration(
                prefixText: 'Rs ',
                label:Text('Amount'),
              ),
            ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.end,
                //  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Expanded(child:
                    Text(_selectDate == null ?'No date selected':
                    formetter.format(_selectDate!),
                    ),),
                    IconButton(
                        onPressed:_presentDatePicker,
                        icon:const Icon(Icons.calendar_month)),
                  ],
                )
            )
          ],
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value:selectCategory,
                  items:Category.values.map(
                        (category) => DropdownMenuItem(
                      value:category,
                      child: Text(
                        category.name.toUpperCase(),
                      ),
                    ),
                  ).toList(),
                  onChanged:(value){
                    if(value == null){
                      return;
                    }
                    setState(() {
                      selectCategory =value;
                    });
                  }),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child:const Text('Cancel',),),
              ElevatedButton(
                  onPressed:_submitExpenseData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 96, 59, 181)
                ),
                  child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}