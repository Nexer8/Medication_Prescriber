import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

class DropDownButton extends StatelessWidget {
  final String hintText;
  final Function onChanged;

  DropDownButton({@required this.hintText, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isDense: true,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey[800],
        ),
      ),
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey[800],
      ),
      onChanged: onChanged,
      items: <String>['Irrelevant', 'BeforeEating', 'AfterEating']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value.sentenceCase,
            style: TextStyle(fontSize: 18, color: Colors.grey[800]),
          ),
        );
      }).toList(),
    );
  }
}
