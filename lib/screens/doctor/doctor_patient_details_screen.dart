import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/components/add_text_form_field.dart';
import 'package:ptsiim/components/detail_edit_text.dart';
import 'package:ptsiim/components/detail_text.dart';
import 'package:ptsiim/components/doctor_panel.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/screens/doctor/doctor_medication_details_screen.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/input_validators.dart';
import 'package:recase/recase.dart';

class DoctorPatientDetailsScreen extends StatefulWidget {
  final Patient patient;
  final List<Medication> medications;
  final Doctor doctor;

  DoctorPatientDetailsScreen(
      {@required this.patient, @required this.medications, this.doctor});

  @override
  _DoctorPatientDetailsScreenState createState() =>
      _DoctorPatientDetailsScreenState();
}

class _DoctorPatientDetailsScreenState
    extends State<DoctorPatientDetailsScreen> {
  final _nameController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _dosageController = TextEditingController();
  final _timingController = TextEditingController();

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _birthdateController;

  final _formKeyDialog = GlobalKey<FormState>();
  final _formKeyPatient = GlobalKey<FormState>();

  String _timing = '';

  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.patient.firstName);
    _lastNameController = TextEditingController(text: widget.patient.lastName);
    _birthdateController =
        TextEditingController(text: widget.patient.birthdate);
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
                    child: Builder(
                      builder: (BuildContext context) => GestureDetector(
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
                                      SizedBox(height: 40),
                                      AddTextFormField(
                                          controller: _nameController,
                                          validator: validateMedicationName,
                                          hintText: 'Name'),
                                      AddTextFormField(
                                          controller: _dosageController,
                                          validator: validateDosage,
                                          hintText: 'Dosage'),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            'Timing',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          value: _timing,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[800],
                                          ),
                                          onChanged: (String newValue) {
                                            _timing = newValue;
                                          },
                                          items: <String>[
                                            'Irrelevant',
                                            'Before eating',
                                            'After eating'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value.pascalCase,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[800]),
                                              ),
                                            );
                                          }).toList(),
                                        ),
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
                                                      timing: _timingController
                                                          .text,
                                                      dosage: int.parse(
                                                          _dosageController
                                                              .text),
                                                      name:
                                                          _nameController.text,
                                                      startDate:
                                                          _startDateController
                                                              .text,
                                                      endDate:
                                                          _endDateController
                                                              .text);

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
                          DetailEditText(
                            label: 'First name',
                            controller: _firstNameController,
                            validator: validateMedicationName,
                          ),
                          DetailEditText(
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
                                      'Amount: ${widget.medications[index].dosage.toString()} When: ${widget.medications[index].timing}',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.grey[600]),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorMedicationDetailsScreen(
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
