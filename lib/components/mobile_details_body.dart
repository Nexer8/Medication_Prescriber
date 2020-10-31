import 'package:flutter/material.dart';

class DetailsBody extends StatelessWidget {
  DetailsBody({@required this.content});

  final Column content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.grey[800],
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: content,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
