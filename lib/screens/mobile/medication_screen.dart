import 'package:flutter/material.dart';
import 'package:ptsiim/components/detail_text.dart';
import 'package:ptsiim/components/details_body.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:recase/recase.dart';

class MobileMedicationScreen extends StatelessWidget {
  final Medication medication;
  final Doctor doctor;

  MobileMedicationScreen({@required this.medication, @required this.doctor});

  @override
  Widget build(BuildContext context) {
    return DetailsBody(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset('assets/details.png',
                height: MediaQuery.of(context).size.height * 0.20),
          ),
          SizedBox(height: 12),
          DetailText(
            label: 'Doctor name',
            data: '${doctor.firstName} ${doctor.lastName}',
          ),
          DetailText(
            label: 'Name',
            data: medication.name,
          ),
          DetailText(
            label: 'Start date',
            data: medication.startDate.substring(0, 10),
          ),
          DetailText(
            label: 'End date',
            data: medication.endDate.substring(0, 10),
          ),
          DetailText(
            label: 'Dosage',
            data: medication.dosage.toString(),
          ),
          DetailText(
            label: 'Timing',
            data: medication.timing.sentenceCase,
          ),
        ],
      ),
    );
  }
}
