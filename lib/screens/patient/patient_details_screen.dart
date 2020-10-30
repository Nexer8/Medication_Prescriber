import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/components/patient/detail_text.dart';
import 'package:ptsiim/components/patient/details_body.dart';
import 'package:ptsiim/models/patient.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  PatientProfileScreen({@required this.patient});

  @override
  Widget build(BuildContext context) {
    return DetailsBody(
      column: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(Icons.account_circle_rounded,
                size: 200, color: Colors.grey[800]),
          ),
          SizedBox(height: 12),
          DetailText(label: 'First name', data: patient.firstName),
          SizedBox(height: 12),
          DetailText(label: 'Last name', data: patient.lastName),
          SizedBox(height: 12),
          DetailText(
            label: 'Personal ID',
            data: patient.personalId.toString(),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'Birthdate',
            data: patient.birthdate.substring(0, 10),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
