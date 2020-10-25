import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';

class MedicationDetailsScreen extends StatelessWidget {
  final Medication medication;
  final Doctor doctor;

  MedicationDetailsScreen({@required this.medication, @required this.doctor});

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
                              child: Image.asset('assets/details.png',
                                  height: MediaQuery.of(context).size.height *
                                      0.25)),
                          SizedBox(height: 10),
                          Text('Personal id',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(medication.patientId.toString(),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('Doctor name',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text('${doctor.firstName} ${doctor.lastName}',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('Name',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(medication.name,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('Start date',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(medication.startDate,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('End date',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(medication.endDate,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('Dosage',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(medication.dosage.toString(),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800])),
                          SizedBox(height: 10),
                          Text('Timing',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text(medication.timing,
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
