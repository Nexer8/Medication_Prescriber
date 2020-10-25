import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/models/Medication.dart';
import 'package:ptsiim/models/Patient.dart';
import 'package:ptsiim/screens/patient/medication_details_screen.dart';

import 'patient_details_screen.dart';
import 'patient_welcome_screen.dart';

class PatientHomeScreen extends StatefulWidget {
  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  //Object for test UI
  Patient patient = Patient(90112003331, 'Jan', 'Kowalski', '20.11.1990');

  List<Medication> _medications = [
    // Medication(90112003331, 'Lekarz 1', 'Apap', '12/12/2020', '15/12/2020', 1,
    //     'After eating'),
    // Medication(90112003331, 'Lekarz 1', 'Skrzypowita', '22/11/2020',
    //     '10/12/2020', 2, 'After eating'),
    // Medication('90112003331', 'Lekarz 2', 'Stoperan', '14/12/2020',
    //     '15/01/2022', 1, 'After eating'),
    // Medication('90112003331', 'Lekarz 2', 'Vitacentrum', '21/10/2020',
    //     '21/11/2025', 2, 'Before eating'),
    // Medication('90112003331', 'Lekarz 2', 'Nospa', '13/01/2021', '15/01/2021',
    //     2, 'Before eating'),
    // Medication('90112003331', 'Lekarz 3', 'Gripex', '28/10/2020', '04/11/2020',
    //     2, 'After eating'),
    // Medication('90112003331', 'Lekarz 3', 'Gripex Max', '28/10/2020',
    //     '04/11/2020', 1, 'After eating'),
  ];

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.logout,
                            color: Colors.grey[800], size: 28),
                        onPressed: () {
                          //TODO: add logout
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PatientWelcomeScreen()));
                        }),
                    IconButton(
                        icon: Icon(Icons.account_circle_rounded,
                            color: Colors.grey[800], size: 28),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PatientProfileScreen(patient: patient)));
                        }),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,\n${patient.firstName}!',
                            style: TextStyle(
                                color: Colors.grey[100], fontSize: 34),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Nice to see you :)',
                            style: TextStyle(
                                color: Colors.grey[100], fontSize: 18),
                          ),
                          SizedBox(height: 20),
                          Text(
                              'Your plan for today:\n${_medications.length} medicines',
                              style: TextStyle(
                                  color: Colors.grey[100], fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(child: Image.asset('assets/drugs.png')),
                  ]),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Daily review:',
                    style: TextStyle(color: Colors.grey[800], fontSize: 24),
                  ),
                ),
                SizedBox(height: 10),
                //TODO: add stream to listview
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _medications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ListTile(
                          leading: Icon(MaterialCommunityIcons.pill,
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                              size: 50),
                          title: Text(_medications[index].name,
                              style: TextStyle(color: Colors.grey[800])),
                          subtitle: Text(
                              'Amout: ${_medications[index].dosage.toString()} When: ${_medications[index].timing}',
                              style: TextStyle(color: Colors.grey[600])),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.grey[600]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicationDetailsScreen(
                                    medication: _medications[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
