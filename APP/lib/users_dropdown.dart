import 'package:flutter/material.dart';
import 'package:app/infrastructure/user_data.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

Widget usersDropdown(BuildContext context, dynamic value, Function onChanged){
  return FormHelper.dropDownWidget(
    context,
    "Select user",
    value,
    users.map((e) => e.toDict()).toList(),
    onChanged,
    (onValidateVal) {
        if (onValidateVal == null) {
          return "Please select a user";
        }
        return null;
      },
    borderColor: Theme.of(context).primaryColor,
    borderFocusColor: Theme.of(context).primaryColor,
    textColor: Colors.white,
    borderRadius: 10,
    optionValue: "id",
    optionLabel: "name",
  );
}