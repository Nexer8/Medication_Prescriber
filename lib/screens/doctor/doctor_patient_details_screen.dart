import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/screens/doctor/doctor_medication_details_screen.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';

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
  TextEditingController _personalIdController;
  TextEditingController _birthdateController;

  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.patient.firstName);
    _lastNameController = TextEditingController(text: widget.patient.lastName);
    _personalIdController =
        TextEditingController(text: widget.patient.personalId.toString());
    _birthdateController =
        TextEditingController(text: widget.patient.birthdate);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add new medicine',
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                contentPadding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                title: Text('Add new medicine'),
                children: [
                  Container(
                    height: 430,
                    width: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            keyboardType: TextInputType.text,
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
                              hintText: "Name",
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: _startDateController,
                            keyboardType: TextInputType.text,
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
                              hintText: "Start date",
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: _endDateController,
                            keyboardType: TextInputType.text,
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
                              hintText: "End date",
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: _dosageController,
                            keyboardType: TextInputType.text,
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
                              hintText: "Dosage",
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: _timingController,
                            keyboardType: TextInputType.text,
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
                              hintText: "Timing",
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.cancel_outlined,
                                      color: Colors.red),
                                  iconSize: 42,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.add_circle_outline,
                                      color: Colors.green),
                                  iconSize: 42,
                                  onPressed: () async {
                                    try {
                                      Medication medication;
                                      medication.doctorId = widget.doctor.id;
                                      medication.patientId =
                                          widget.patient.personalId;
                                      medication.timing =
                                          _timingController.text;
                                      medication.dosage =
                                          int.parse(_dosageController.text);
                                      medication.name = _nameController.text;
                                      medication.startDate =
                                          _startDateController.text;
                                      medication.endDate =
                                          _endDateController.text;

                                      var medicationDataAccess = DIContainer
                                          .getIt
                                          .get<MedicationDataAccess>();

                                      await medicationDataAccess
                                          .createMedication(medication);
                                      //Create object and add to database
                                      Navigator.pop(context);
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
                                    }
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 256),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 128, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Icon(Icons.account_circle_rounded,
                              size: 150, color: Colors.grey[800]),
                        ),
                        SizedBox(height: 10),
                        Text('First name',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _firstNameController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('Last name',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _lastNameController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('PESEL',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _personalIdController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('Birthdate',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _birthdateController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
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
                                      'Amout: ${widget.medications[index].dosage.toString()} When: ${widget.medications[index].timing}',
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
                                    if (_firstNameController.text != null) {
                                      widget.patient.firstName =
                                          _firstNameController.text;
                                    }
                                    if (_lastNameController.text != null) {
                                      widget.patient.lastName =
                                          _lastNameController.text;
                                    }
                                    if (_personalIdController.text != null) {
                                      widget.patient.personalId =
                                          int.parse(_personalIdController.text);
                                    }
                                    // TODO: To fix displaying
                                    if (_birthdateController != null) {
                                      widget.patient.birthdate =
                                          _birthdateController.text;
                                    }

                                    var patientDataAccess = DIContainer.getIt
                                        .get<PatientDataAccess>();

                                    try {
                                      await patientDataAccess
                                          .editPatientData(widget.patient);

                                      Navigator.pop(context);
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
                                    }
                                  }),
                            ])
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
