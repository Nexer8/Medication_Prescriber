import 'package:flutter/material.dart';
import 'package:ptsiim/utils/style_constants.dart';
import 'package:recase/recase.dart';

class DropDownButton extends StatelessWidget {
  final String timing;
  final Function onChanged;

  DropDownButton({@required this.timing, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          isDense: true,
          value: timing.pascalCase,
          decoration: InputDecoration(
            labelText: 'Timing',
            labelStyle: TextStyle(
              fontSize: 21,
              color: Colors.grey[600],
            ),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
          style: kContentTextStyle,
          onChanged: onChanged,
          items: <String>['Irrelevant', 'BeforeEating', 'AfterEating']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.sentenceCase,
                style: kContentTextStyle,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
