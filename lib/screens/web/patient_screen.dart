import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/components/date_picker.dart';
import 'package:ptsiim/components/detail_text.dart';
import 'package:ptsiim/components/detail_text_form_field.dart';
import 'package:ptsiim/components/doctor_panel.dart';
import 'package:ptsiim/components/drop_down_button.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/screens/web/medication_screen.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/input_validators.dart';
import 'package:recase/recase.dart';

class WebPatientScreen extends StatefulWidget {
  final Patient patient;
  final List<Medication> medications;
  final Doctor doctor;

  WebPatientScreen(
      {@required this.patient, @required this.medications, this.doctor});

  @override
  _WebPatientScreenState createState() => _WebPatientScreenState();
}

class _WebPatientScreenState extends State<WebPatientScreen> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  String _startDate;
  String _endDate;
  String _timing;

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _birthdateController;

  final _formKeyDialog = GlobalKey<FormState>();
  final _formKeyPatient = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.patient.firstName);
    _lastNameController = TextEditingController(text: widget.patient.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add new medicaation',
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Form(
                    key: _formKeyDialog,
                    child: StatefulBuilder(
                      builder: (context, setState) => GestureDetector(
                        child: SimpleDialog(
                          contentPadding: EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          title: Text('Enter new medication'),
                          children: [
                            Container(
                              height: 350,
                              width: 400,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DetailTextFormField(
                                          controller: _nameController,
                                          validator: validateMedicationName,
                                          label: 'Name'),
                                      DetailTextFormField(
                                          controller: _dosageController,
                                          validator: validateDosage,
                                          label: 'Dosage'),
                                      DatePicker(
                                        date: _startDate,
                                        label: 'Start Date',
                                        onTap: () async {
                                          DateTime initialDate;
                                          if (_startDate == null) {
                                            initialDate = DateTime.now();
                                          } else {
                                            initialDate =
                                                DateTime.parse(_startDate);
                                          }
                                          DateTime picked =
                                              await showDatePicker(
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
                                                _startDate =
                                                    picked.toIso8601String();
                                              },
                                            );
                                        },
                                      ),
                                      DatePicker(
                                        date: _endDate,
                                        label: 'End Date',
                                        onTap: () async {
                                          DateTime initialDate;
                                          if (_endDate == null) {
                                            initialDate = DateTime.now();
                                          } else {
                                            initialDate =
                                                DateTime.parse(_endDate);
                                          }
                                          DateTime picked =
                                              await showDatePicker(
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
                                                _endDate =
                                                    picked.toIso8601String();
                                              },
                                            );
                                        },
                                      ),
                                      DropDownButton(
                                        hintText: 'Timing',
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _timing = newValue;
                                          });
                                        },
                                      ),
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
                                              }),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.green,
                                            ),
                                            iconSize: 42,
                                            onPressed: () async {
                                              if (_formKeyDialog.currentState
                                                  .validate()) {
                                                try {
                                                  var medication = Medication(
                                                      id: 0,
                                                      doctorId:
                                                          widget.doctor.id,
                                                      patientId: widget
                                                          .patient.personalId,
                                                      timing: _timing,
                                                      dosage: int.parse(
                                                          _dosageController
                                                              .text),
                                                      name:
                                                          _nameController.text,
                                                      startDate: _startDate,
                                                      endDate: _endDate);

                                                  var medicationDataAccess =
                                                      DIContainer.getIt.get<
                                                          MedicationDataAccess>();

                                                  await medicationDataAccess
                                                      .createMedication(
                                                          medication);

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
        body: Form(
          key: _formKeyPatient,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 128, vertical: 32),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(Icons.account_circle,
                                size: 200, color: Colors.grey[800]),
                          ),
                          SizedBox(height: 10),
                          DetailText(
                            label: 'PESEL',
                            data: widget.patient.personalId.toString(),
                          ),
                          DetailText(
                            label: 'Birthdate',
                            data: widget.patient.birthdate.substring(0, 10),
                          ),
                          DetailTextFormField(
                            label: 'First name',
                            controller: _firstNameController,
                            validator: validateMedicationName,
                          ),
                          DetailTextFormField(
                            label: 'Last name',
                            controller: _lastNameController,
                            validator: validateMedicationName,
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.medications.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: ListTile(
                                  leading: Icon(MaterialCommunityIcons.pill,
                                      color: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      size: 50),
                                  title: Text(widget.medications[index].name,
                                      style:
                                          TextStyle(color: Colors.grey[800])),
                                  subtitle: Text(
                                      'Dosage: ${widget.medications[index].dosage.toString()} Timing: ${widget.medications[index].timing.sentenceCase}',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.grey[600]),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WebMedicationScreen(
                                          medication: widget.medications[index],
                                          doctor: widget.doctor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  iconSize: 42,
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    var patientDataAccess = DIContainer.getIt
                                        .get<PatientDataAccess>();

                                    try {
                                      await patientDataAccess.deletePatientById(
                                          widget.patient.personalId);

                                      Navigator.pop(context);
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
                                    }
                                  }),
                              IconButton(
                                iconSize: 42,
                                icon: Icon(Icons.save, color: Colors.blue),
                                onPressed: () async {
                                  if (_formKeyPatient.currentState.validate()) {
                                    widget.patient.firstName =
                                        _firstNameController.text;
                                    widget.patient.lastName =
                                        _lastNameController.text;
                                    widget.patient.birthdate =
                                        _birthdateController.text;

                                    var patientDataAccess = DIContainer.getIt
                                        .get<PatientDataAccess>();

                                    try {
                                      await patientDataAccess
                                          .editPatientData(widget.patient);

                                      Navigator.pop(context);
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
