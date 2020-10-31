import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/components/detail_text.dart';
import 'file:///E:/Flutter/Medication_Prescriber/lib/components/mobile_details_body.dart';
import 'package:ptsiim/models/patient.dart';

class PatientProfileScreen extends StatelessWidget {
  final Patient patient;

  PatientProfileScreen({@required this.patient});

  @override
  Widget build(BuildContext context) {
    return DetailsBody(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.account_circle_rounded,
              size: 200,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'Personal ID',
            data: patient.personalId.toString(),
          ),
          DetailText(
            label: 'First name',
            data: patient.firstName,
          ),
          DetailText(
            label: 'Last name',
            data: patient.lastName,
          ),
          DetailText(
            label: 'Birthdate',
            data: patient.birthdate.substring(0, 10),
          ),
        ],
      ),
    );
  }
}
