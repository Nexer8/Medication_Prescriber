import 'package:flutter/material.dart';

class IdTextFormField extends StatelessWidget {
  IdTextFormField({@required this.controller, @required this.validator});

  final TextEditingController controller;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(24.0, 2.0, 2.0, 0.0),
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
        hintText: "Please enter ID",
      ),
      validator: validator,
    );
  }
}
