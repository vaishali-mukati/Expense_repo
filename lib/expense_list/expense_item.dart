import 'package:flutter/material.dart';

import '../models/expnse_model.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem(this.expense,{super.key});

  final ExpenseModel expense;
  @override
  Widget build( context) {
    return Card(child:Padding(
      padding:const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(expense.title,
            style:Theme.of(context).textTheme.titleLarge,

          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('\R\s${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8),
                  Text(expense.formettedDate),
                ],
              )
            ],
          )
        ],
      ),),);
  }
}