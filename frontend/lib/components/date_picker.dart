import 'package:flutter/material.dart';
import 'package:medication_prescriber/utils/input_validators.dart';
import 'package:medication_prescriber/utils/style_constants.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final Function onTap;
  final TextEditingController controller;
  final Function validator;

  DatePicker({
    @required this.label,
    this.onTap,
    this.controller,
    this.validator,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: kLabelTextStyle,
        ),
        TextFormField(
            controller: widget.controller,
            validator: validateDate,
            decoration:
                InputDecoration(isDense: true, enabledBorder: InputBorder.none),
            style: kContentTextStyle,
            readOnly: true,
            onTap: widget.onTap),
        SizedBox(height: 12),
      ],
    );
  }
}
