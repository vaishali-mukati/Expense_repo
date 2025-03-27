
import 'package:expense_tracker/models/expnse_model.dart';
import 'package:flutter/material.dart';

import 'expense_item.dart';

class ExpenseList extends StatelessWidget{
  const ExpenseList({super.key,required this.expenses,required this.onRemoveExpense});

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  @override
  Widget build( context) {
    return ListView.builder(itemCount:expenses.length ,
      itemBuilder: (ctx,index) => Dismissible(key:
      ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal:Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction){
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}