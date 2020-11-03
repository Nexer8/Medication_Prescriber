import 'package:flutter/material.dart';
import 'package:ptsiim/utils/style_constants.dart';

class RoundedTextFormField extends StatelessWidget {
  RoundedTextFormField(
      {@required this.controller,
      @required this.validator,
      @required this.hintText});

  final TextEditingController controller;
  final String hintText;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: Colors.green,
      style: kContentTextStyle,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(24.0, 2.0, 2.0, 0.0),
        filled: true,
        fillColor: Colors.grey[100],
        focusColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: kContentTextStyle,
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
