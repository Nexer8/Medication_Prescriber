import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/screens/mobile/home_screen.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';

import 'screens/mobile/welcome_screen.dart';
import 'screens/web/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DIContainer.registerServices();

  Patient patient;
  String patientId;

  if (!kIsWeb) {
    var secureStorage = DIContainer.getIt.get<FlutterSecureStorage>();
    patientId = await secureStorage.read(key: 'personalId');
  }

  if (patientId != null) {
    var patientDataAccess = DIContainer.getIt.get<PatientDataAccess>();
    patient = await patientDataAccess.getPatientById(int.parse(patientId));
  }

  runApp(
    MedicationPrescriber(
      patient: patient,
    ),
  );
}

class MedicationPrescriber extends StatelessWidget {
  final Patient patient;

  const MedicationPrescriber({Key key, this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medication prescriber',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: kIsWeb
          ? WebWelcomeScreen()
          : patient != null
              ? MobileHomeScreen(patient: patient)
              : MobileWelcomeScreen(),
    );
  }
}
