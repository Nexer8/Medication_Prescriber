import 'package:flutter/material.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';

import 'patient_home_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PatientWelcomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Medication prescriber ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 48,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Icon(
                          FlutterIcons.capsules_faw5s,
                          color: Colors.grey[100],
                          size: 220,
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _idController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0),
                            filled: true,
                            fillColor: Colors.grey[100],
                            focusColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey[800],
                            ),
                            hintText: "Please enter your PESEL",
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter personal ID';
                            if (value.length < 9)
                              return 'Personal ID is too short';
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                            color: Colors.grey[100],
                            textColor: Colors.grey[800],
                            child: Text(
                              'Login'.toUpperCase(),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide.none,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var patientDataAccess =
                                    DIContainer.getIt.get<PatientDataAccess>();
                                var medicationDataAccess = DIContainer.getIt
                                    .get<MedicationDataAccess>();

                                try {
                                  Patient patient =
                                      await patientDataAccess.getPatientById(
                                          int.parse(_idController.text));

                                  List<Medication> medications =
                                      await medicationDataAccess
                                          .getMedicationsByPatientId(
                                              patient.personalId);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PatientHomeScreen(
                                        patient: patient,
                                        medications: medications,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  ErrorHandlingSnackbar.show(e, context);
                                }
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
