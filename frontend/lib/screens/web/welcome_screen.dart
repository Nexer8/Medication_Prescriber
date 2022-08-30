import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medication_prescriber/components/error_handling_snackbar.dart';
import 'package:medication_prescriber/components/rounded_text_form_field.dart';
import 'package:medication_prescriber/components/login_raised_button.dart';
import 'package:medication_prescriber/models/doctor.dart';
import 'package:medication_prescriber/screens/web/home_screen.dart';
import 'package:medication_prescriber/services/doctor_data_access.dart';
import 'package:medication_prescriber/services/service_locator.dart';
import 'package:medication_prescriber/utils/input_validators.dart';

class WebWelcomeScreen extends StatelessWidget {
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
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Medication prescriber',
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Management system for doctors',
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Icon(
                      FlutterIcons.capsules_faw5s,
                      color: Colors.grey[100],
                      size: 350,
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 550,
                      child: RoundedTextFormField(
                        hintText: "Please enter ID",
                        controller: _idController,
                        validator: validateDoctorId,
                      ),
                    ),
                    SizedBox(height: 20),
                    Builder(
                      builder: (context) => LoginRaisedButton(
                        formKey: _formKey,
                        controller: _idController,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var doctorDataAccess =
                                DIContainer.getIt.get<DoctorDataAccess>();

                            try {
                              Doctor doctor = await doctorDataAccess
                                  .getDoctorById(int.parse(_idController.text));

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebHomeScreen(
                                    doctor: doctor,
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
    );
  }
}
