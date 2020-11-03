import 'package:flutter/material.dart';
import 'package:ptsiim/utils/style_constants.dart';

class DetailTextFormField extends StatelessWidget {
  const DetailTextFormField({
    Key key,
    @required this.controller,
    @required this.validator,
    @required this.label,
  });

  final TextEditingController controller;
  final Function validator;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kLabelTextStyle,
        ),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration:
              InputDecoration(isDense: true, enabledBorder: InputBorder.none),
          style: kContentTextStyle,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
