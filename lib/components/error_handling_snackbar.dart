import 'package:flutter/material.dart';

class ErrorHandlingSnackbar {
  static const displayDuration = Duration(seconds: 4);

  static void show(Exception e, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: displayDuration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      content: Text(
        e.toString(),
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
      ),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          Scaffold.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
}
