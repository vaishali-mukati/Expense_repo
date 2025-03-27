
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expnse_model.dart';
import 'package:flutter/material.dart';

import 'expense_item.dart';

class ExpenseList extends StatefulWidget{
  const ExpenseList({super.key,required this.expenses,required this.onRemoveExpense});

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final Stream<QuerySnapshot> expenseStream = FirebaseFirestore.instance.collection('Expense').snapshots();
  @override
  Widget build( context) {
    return ListView.builder(itemCount:widget.expenses.length ,
      itemBuilder: (ctx,index) => Dismissible(key:
      ValueKey(widget.expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal:Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction){
          widget.onRemoveExpense(widget.expenses[index]);
        },
        child: ExpenseItem(widget.expenses[index]),
      ),
    );
  }
}