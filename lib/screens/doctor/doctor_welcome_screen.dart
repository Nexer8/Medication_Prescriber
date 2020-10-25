import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/services/doctor_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';

import 'doctor_home_screen.dart';

class DoctorWelcomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.green,
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text('Medication prescriber',
                          style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 80,
                              fontWeight: FontWeight.bold)),
                      Text('System management for doctors',
                          style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 42,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Icon(
                        FlutterIcons.capsules_faw5s,
                        color: Colors.grey[100],
                        size: 400,
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 550,
                        child: TextFormField(
                          controller: _idController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter ID';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.green[300],
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(24.0, 2.0, 2.0, 0.0),
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
                            hintText: "Please enter your doctor ID",
                          ),
                        ),
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
                          //TODO: Auth
                          if (_formKey.currentState.validate()) {
                            var doctorDataAccess =
                                DIContainer.getIt.get<DoctorDataAccess>();

                            var patientDataAccess =
                                DIContainer.getIt.get<PatientDataAccess>();

                            try {
                              Doctor doctor = await doctorDataAccess
                                  .getDoctorById(int.parse(_idController.text));

                              List<Patient> patients = await patientDataAccess
                                  .getPatientsByDoctorId(doctor.id);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorHomeScreen(
                                    doctor: doctor,
                                    patients: patients,
                                  ),
                                ),
                              );
                            } catch (e) {
                              ErrorHandlingSnackbar.show(e, context);
                            }
                          }
                        },
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
