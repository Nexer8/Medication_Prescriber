import 'package:flutter/material.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/components/id_text_form_field.dart';
import 'package:ptsiim/components/login_raised_button.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/input_validators.dart';

import 'patient_home_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PatientWelcomeScreen extends StatefulWidget {
  @override
  _PatientWelcomeScreenState createState() => _PatientWelcomeScreenState();
}

class _PatientWelcomeScreenState extends State<PatientWelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Medication prescriber ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Icon(
                        FlutterIcons.capsules_faw5s,
                        color: Colors.grey[100],
                        size: 220,
                      ),
                      SizedBox(height: 30),
                      IdTextFormField(
                        controller: _idController,
                        validator: validatePersonalId,
                      ),
                      SizedBox(height: 20),
                      Builder(
                        builder: (context) => LoginRaisedButton(
                          formKey: _formKey,
                          controller: _idController,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              var patientDataAccess =
                                  DIContainer.getIt.get<PatientDataAccess>();
                              var medicationDataAccess =
                                  DIContainer.getIt.get<MedicationDataAccess>();

                              try {
                                Patient patient =
                                    await patientDataAccess.getPatientById(
                                        int.parse(_idController.text));

                                List<Medication> medications =
                                    await medicationDataAccess
                                        .getMedicationsByPatientIdAndDate(
                                            patient.personalId, DateTime.now());

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
                          },
                        ),
                      ),
                    ],
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
