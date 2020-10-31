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
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
        filled: true,
        fillColor: Colors.grey[100],
        focusColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          color: Colors.grey[800],
        ),
        hintText: hintText,
      ),
    );
  }
}
