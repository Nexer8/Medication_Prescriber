import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/models/Patient.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  PatientProfileScreen({@required this.patient});

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
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(Icons.keyboard_arrow_left, size: 28),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(Icons.account_circle_rounded,
                                size: 180, color: Colors.grey[800]),
                          ),
                          SizedBox(height: 10),
                          Text('First name',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(patient.firstName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('Last name',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(patient.lastName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('PESEL',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(patient.personalId.toString(),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('Birthdate',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(patient.birthdate,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                        ],
                      ),
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
