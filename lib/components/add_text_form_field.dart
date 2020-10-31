import 'package:flutter/material.dart';

class AddTextFormField extends StatelessWidget {
  AddTextFormField({
    @required this.controller,
    @required this.validator,
    @required this.hintText,
  });

  final TextEditingController controller;
  final Function validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: TextInputType.text,
          cursorColor: Colors.green,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[800],
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            enabledBorder: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey[800],
            ),
            hintText: hintText,
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
