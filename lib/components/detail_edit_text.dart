import 'package:flutter/material.dart';

class DetailEditText extends StatelessWidget {
  const DetailEditText({
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
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(enabledBorder: InputBorder.none),
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
