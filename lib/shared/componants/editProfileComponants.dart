import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'componants.dart';

Widget RadioButton(
    {required String title,
    required int value,
    required int groupValue,
    required ValueChanged onChanged}) {
  return Row(
    children: <Widget>[
      arabicText(
        text: title,
        size: 13,
      ),
      Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: Colors.blue.shade300,
      ),
    ],
  );
}
