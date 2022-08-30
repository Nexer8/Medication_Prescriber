import 'package:flutter/material.dart';

class LoginRaisedButton extends StatelessWidget {
  LoginRaisedButton({
    @required this.formKey,
    @required this.controller,
    @required this.onPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.grey[100],
      textColor: Colors.grey[800],
      child: Text(
        'Login'.toUpperCase(),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide.none,
      ),
      onPressed: onPressed,
    );
  }
}
