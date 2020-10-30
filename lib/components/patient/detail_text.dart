import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  DetailText({@required this.label, @required this.data});

  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        Text(
          data,
          style: TextStyle(fontSize: 18, color: Colors.grey[800]),
        ),
      ],
    );
  }
}
