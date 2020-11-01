import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditDatePicker extends StatelessWidget {
  final String date;
  final String label;
  final Function onTap;

  const EditDatePicker(
      {@required this.date, @required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        if (date == null)
          InkWell(
            child: Text(
              "                    ",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
              ),
            ),
            onTap: onTap,
          ),
        if (date != null)
          InkWell(
            child: Text(
              date.substring(0, 10),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
              ),
            ),
            onTap: onTap,
          ),
        SizedBox(height: 12),
      ],
    );
  }
}
