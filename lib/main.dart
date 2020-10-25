import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ptsiim/screens/doctor/doctor_welcome_screen.dart';
import 'package:ptsiim/screens/patient/patient_welcome_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MedicationPrescriber());
}

class MedicationPrescriber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medication prescriber',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: kIsWeb ? DoctorWelcomeScreen() : PatientWelcomeScreen());
  }
}
