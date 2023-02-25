import 'package:flutter/material.dart';
import 'package:app/infrastructure/user_data.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'themes/app_theme.dart';

Widget usersDropdown(BuildContext context, dynamic value, Function onChanged) {
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
    contentPadding: 15,
    borderColor: AppTheme.textPrimary,
    borderFocusColor: AppTheme.textPrimary,
    textColor: Colors.white,
    borderRadius: 10,
    optionValue: "id",
    optionLabel: "name",
  );
}
