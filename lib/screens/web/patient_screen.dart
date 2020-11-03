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
import 'package:ptsiim/services/doctor_data_access.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/api_constants.dart';
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
  final _startDateController = TextEditingController(text: '');
  final _endDateController = TextEditingController(text: '');
  String _timing = 'Irrelevant';

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;

  final _formKeyDialog = GlobalKey<FormState>();
  final _formKeyPatient = GlobalKey<FormState>();

  var medicationDataAccess = DIContainer.getIt.get<MedicationDataAccess>();

  Future<List<Medication>> _medicationsList;

  Future<Null> refreshList() async {
    setState(() {
      _medicationsList = medicationDataAccess
          .getMedicationsByPatientId(widget.patient.personalId);
    });
  }

  void clearController() {
    _nameController.clear();
    _dosageController.clear();
    _startDateController.clear();
    _endDateController.clear();
  }

  void initState() {
    super.initState();
    _medicationsList = medicationDataAccess
        .getMedicationsByPatientId(widget.patient.personalId);
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
          tooltip: 'Add new medication',
          child: Icon(Icons.add),
          onPressed: () async {
            bool isRefreshNeeded = await showDialog(
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
                          title: Text('New medication'),
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
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
                                        controller: _startDateController,
                                        validator: validateDate,
                                        label: 'Start date',
                                        onTap: () async {
                                          DateTime initialDate;
                                          if (_startDateController.text == '') {
                                            initialDate = DateTime.now();
                                          } else {
                                            initialDate = DateTime.parse(
                                                _startDateController.text);
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
                                                _startDateController.text =
                                                    picked
                                                        .toIso8601String()
                                                        .substring(0, 10);
                                              },
                                            );
                                        },
                                      ),
                                      DatePicker(
                                        controller: _endDateController,
                                        validator: validateDate,
                                        label: 'End date',
                                        onTap: () async {
                                          DateTime initialDate;
                                          if (_endDateController.text == '') {
                                            initialDate = DateTime.now();
                                          } else {
                                            initialDate = DateTime.parse(
                                                _endDateController.text);
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
                                                _endDateController.text = picked
                                                    .toIso8601String()
                                                    .substring(0, 10);
                                              },
                                            );
                                        },
                                      ),
                                      DropDownButton(
                                        timing: 'Irrelevant',
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
                                              tooltip: 'Cancel',
                                              icon: Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.red,
                                              ),
                                              iconSize: 42,
                                              onPressed: () {
                                                clearController();
                                                Navigator.pop(context, false);
                                              }),
                                          IconButton(
                                            tooltip: 'Add',
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
                                                      startDate:
                                                          _startDateController
                                                              .text,
                                                      endDate:
                                                          _endDateController
                                                                  .text +
                                                              endDateTime);

                                                  var medicationDataAccess =
                                                      DIContainer.getIt.get<
                                                          MedicationDataAccess>();

                                                  await medicationDataAccess
                                                      .createMedication(
                                                          medication);
                                                  clearController();
                                                  Navigator.pop(context, true);
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
            if (isRefreshNeeded != null && isRefreshNeeded == true)
              refreshList();
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
                            validator: validateName,
                          ),
                          DetailTextFormField(
                            label: 'Last name',
                            controller: _lastNameController,
                            validator: validateName,
                          ),
                          SizedBox(height: 20),
                          FutureBuilder(
                            future: _medicationsList,
                            builder: (context, AsyncSnapshot snap) {
                              if (!snap.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snap.data.length,
                                  itemBuilder: (context, index) {
                                    Medication medication = snap.data[index];
                                    return Card(
                                      color: Colors.grey[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      child: ListTile(
                                        leading: Icon(
                                            MaterialCommunityIcons.pill,
                                            color: Colors.primaries[Random()
                                                .nextInt(
                                                    Colors.primaries.length)],
                                            size: 50),
                                        title: Text(medication.name,
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                            )),
                                        subtitle: Text(
                                          'Dosage: ${medication.dosage.toString()} Timing: ${medication.timing.sentenceCase}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        trailing: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.grey[600]),
                                        onTap: () async {
                                          var doctorDataAccess = DIContainer
                                              .getIt
                                              .get<DoctorDataAccess>();
                                          Doctor doctorFromMedication =
                                              await doctorDataAccess
                                                  .getDoctorById(
                                                      medication.doctorId);

                                          var isRefreshNeeded =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WebMedicationScreen(
                                                medication: medication,
                                                doctor: widget.doctor,
                                                doctorFromMedication:
                                                    doctorFromMedication,
                                              ),
                                            ),
                                          );
                                          if (isRefreshNeeded != null &&
                                              isRefreshNeeded == true) {
                                            refreshList();
                                          }
                                        },
                                      ),
                                    );
                                  },
                                );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  tooltip: 'Delete',
                                  iconSize: 42,
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    var patientDataAccess = DIContainer.getIt
                                        .get<PatientDataAccess>();

                                    try {
                                      await patientDataAccess.deletePatientById(
                                          widget.patient.personalId);

                                      Navigator.pop(context, true);
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
                                    }
                                  }),
                              IconButton(
                                tooltip: 'Save',
                                iconSize: 42,
                                icon: Icon(Icons.save, color: Colors.blue),
                                onPressed: () async {
                                  if (_formKeyPatient.currentState.validate()) {
                                    widget.patient.firstName =
                                        _firstNameController.text;
                                    widget.patient.lastName =
                                        _lastNameController.text;

                                    var patientDataAccess = DIContainer.getIt
                                        .get<PatientDataAccess>();

                                    try {
                                      await patientDataAccess
                                          .editPatientData(widget.patient);

                                      Navigator.pop(context, true);
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
