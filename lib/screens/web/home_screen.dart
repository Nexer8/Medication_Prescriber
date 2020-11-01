import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/components/date_picker.dart';
import 'package:ptsiim/components/detail_text_form_field.dart';
import 'package:ptsiim/components/doctor_panel.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/screens/web/patient_screen.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/input_validators.dart';

class WebHomeScreen extends StatefulWidget {
  final Doctor doctor;
  final List<Patient> patients;

  const WebHomeScreen({this.doctor, this.patients});

  @override
  _WebHomeScreenState createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _personalIdController = TextEditingController();
  String _birthdate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new patient',
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Form(
                  key: _formKey,
                  child: StatefulBuilder(
                    builder: (context, setState) => GestureDetector(
                      child: SimpleDialog(
                        contentPadding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        title: Text('Enter new patient'),
                        children: [
                          Container(
                            height: 350,
                            width: 400,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailTextFormField(
                                      controller: _personalIdController,
                                      validator: validatePersonalId,
                                      label: 'PESEL'),
                                  DatePicker(
                                    date: _birthdate,
                                    label: 'Birthdate',
                                    onTap: () async {
                                      DateTime initialDate;
                                      if (_birthdate == null) {
                                        initialDate = DateTime.now();
                                      } else {
                                        initialDate =
                                            DateTime.parse(_birthdate);
                                      }
                                      DateTime picked = await showDatePicker(
                                        context: context,
                                        initialDate: initialDate,
                                        firstDate: DateTime(1920),
                                        lastDate: DateTime(2050),
                                      );
                                      if (picked != null &&
                                          picked != initialDate)
                                        setState(
                                          () {
                                            initialDate = picked;
                                            _birthdate =
                                                picked.toIso8601String();
                                          },
                                        );
                                    },
                                  ),
                                  DetailTextFormField(
                                      controller: _firstNameController,
                                      validator: validateName,
                                      label: 'First name'),
                                  DetailTextFormField(
                                      controller: _lastNameController,
                                      validator: validateName,
                                      label: 'Last name'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.red,
                                        ),
                                        iconSize: 42,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.green,
                                        ),
                                        iconSize: 42,
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            try {
                                              var patient = Patient(
                                                  personalId: int.parse(
                                                      _personalIdController
                                                          .text),
                                                  firstName:
                                                      _firstNameController.text,
                                                  lastName:
                                                      _lastNameController.text,
                                                  birthdate: _birthdate);

                                              var patientDataAccess =
                                                  DIContainer.getIt
                                                      .get<PatientDataAccess>();

                                              await patientDataAccess
                                                  .createPatient(patient);

                                              Navigator.pop(context);
                                            } catch (e) {
                                              ErrorHandlingSnackbar.show(
                                                  e, context);
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
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
            ),
          );
        },
      ),
      body: SafeArea(
        child: DoctorPanel(
          doctor: widget.doctor,
          content: Expanded(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 128,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Patients',
                        style: TextStyle(
                          fontSize: 42,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.patients.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  FlutterIcons.account_mco,
                                  size: 50,
                                ),
                                title: Text(
                                  '${widget.patients[index].firstName} ${widget.patients[index].lastName}',
                                ),
                                subtitle: Text(
                                  widget.patients[index].personalId.toString(),
                                ),
                                onTap: () async {
                                  var medicationDataAccess = DIContainer.getIt
                                      .get<MedicationDataAccess>();

                                  try {
                                    List<Medication> medications =
                                        await medicationDataAccess
                                            .getMedicationsByPatientId(widget
                                                .patients[index].personalId);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebPatientScreen(
                                          patient: widget.patients[index],
                                          medications: medications,
                                          doctor: widget.doctor,
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    ErrorHandlingSnackbar.show(e, context);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      )
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
