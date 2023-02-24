import 'package:app/themes/app_theme.dart';
import 'package:app/widgets/custom_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'users_dropdown.dart';

class AppAlerts {
  static void displayDialogAndroid(
      BuildContext context, Text? title, Widget content, Future<void> Function() function) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: title,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(20)),
            content: content,
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    function();
                    Navigator.pop(context);
                    },
                  child: Text(
                    "Add",
                    style: TextStyle(color: AppTheme.textPrimary),
                  ))
            ],
          );
        });
  }

  static Column nameInput(Function(String?) onChanged) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomInputField(
            labelText: "Name",
            hintText: "Example: John",
            onChanged: onChanged,
          )
        ]);
  }

  static Column expenseInput(
      Widget usersDropdown,
      Function(String?) onChangedExpense,
      ) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          usersDropdown,
          SizedBox(height: 20),
          CustomInputField(
            labelText: "Expense",
            hintText: "Example: 100",
            onChanged: onChangedExpense,
          )
        ]);
  }

  static void displayDialogIOS(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Titulo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Contenido de alerta"),
              SizedBox(height: 20),
              FlutterLogo(size: 100)
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok"))
          ],
        );
      },
    );
  }
}
