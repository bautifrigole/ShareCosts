import 'package:app/domain/domain.dart';
import 'package:flutter/material.dart';

Widget expensePanel(BuildContext context, Expense expense) {
  TextStyle style = const TextStyle(fontSize: 18);
  return Container(
      decoration: BoxDecoration(
      border: Border.all(color: Colors.white30, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: ListTile(
      title: Text(expense.description, style: style),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("by: ${expense.payerUser.name}", style: style),
          Text("\$ ${expense.amount}", style: style),
        ],
      ),
    ),
  );
}