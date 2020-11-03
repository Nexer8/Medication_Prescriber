import 'package:flutter/material.dart';
import 'package:ptsiim/utils/style_constants.dart';

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
          style: kLabelTextStyle,
        ),
        Text(
          data,
          style: kContentTextStyle,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
