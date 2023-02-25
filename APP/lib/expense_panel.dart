import 'package:app/domain/domain.dart';
import 'package:app/themes/app_theme.dart';
import 'package:flutter/material.dart';

Widget expensePanel(BuildContext context, Expense expense) {
  TextStyle style = const TextStyle(fontSize: 20);
  return Container(
    padding: const EdgeInsetsDirectional.all(5),
    decoration: BoxDecoration(
      color: AppTheme.primary,
      border: Border.all(color: Color.fromARGB(255, 72, 39, 161), width: 5),
      borderRadius: BorderRadius.circular(40),
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
