import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
enum Category { food, travel, leisure, work }

const uuid = Uuid();
final formetter = DateFormat.yMd();
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();


  String get formettedDate{
    return formetter.format(date);
  }
}


class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses , this.category)
      :expenses = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<ExpenseModel> expenses;

  double get totalExpenses{
    double sum = 0;

    for(final expense in expenses){
      sum += expenses.length;
    }
    return sum;
  }
}