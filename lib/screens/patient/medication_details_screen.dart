import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/components/patient/detail_text.dart';
import 'package:ptsiim/components/patient/details_body.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:recase/recase.dart';

class MedicationDetailsScreen extends StatelessWidget {
  final Medication medication;
  final Doctor doctor;

  MedicationDetailsScreen({@required this.medication, @required this.doctor});

  @override
  Widget build(BuildContext context) {
    return DetailsBody(
      column: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset('assets/details.png',
                height: MediaQuery.of(context).size.height * 0.20),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'Personal ID',
            data: medication.patientId.toString(),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'Doctor name',
            data: '${doctor.firstName} ${doctor.lastName}',
          ),
          SizedBox(height: 12),
          DetailText(label: 'Name', data: medication.name),
          SizedBox(height: 12),
          DetailText(
            label: 'Start date',
            data: medication.startDate.substring(0, 10),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'End date',
            data: medication.endDate.substring(0, 10),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'Dosage',
            data: medication.dosage.toString(),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'Timing',
            data: medication.timing.sentenceCase,
          ),
        ],
      ),
    );
  }
}
