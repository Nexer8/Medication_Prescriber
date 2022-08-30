import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medication_prescriber/components/date_picker.dart';
import 'package:medication_prescriber/components/detail_text_form_field.dart';
import 'package:medication_prescriber/components/doctor_panel.dart';
import 'package:medication_prescriber/components/error_handling_snackbar.dart';
import 'package:medication_prescriber/models/doctor.dart';
import 'package:medication_prescriber/models/medication.dart';
import 'package:medication_prescriber/models/patient.dart';
import 'package:medication_prescriber/screens/web/patient_screen.dart';
import 'package:medication_prescriber/services/medication_data_access.dart';
import 'package:medication_prescriber/services/patient_data_access.dart';
import 'package:medication_prescriber/services/service_locator.dart';
import 'package:medication_prescriber/utils/input_validators.dart';

class WebHomeScreen extends StatefulWidget {
  final Doctor doctor;

  const WebHomeScreen({this.doctor});

  @override
  _WebHomeScreenState createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _personalIdController = TextEditingController();
  final _birthdateController = TextEditingController(text: "");
  final _searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var patientDataAccess = DIContainer.getIt.get<PatientDataAccess>();

  String searchedString = '';

  Future<List<Patient>> _patientsList;

  Future<Null> refreshList() async {
    setState(() {
      _patientsList = patientDataAccess.getPatientsByDoctorId(widget.doctor.id);
    });
  }

  void clearController() {
    _firstNameController.clear();
    _lastNameController.clear();
    _personalIdController.clear();
    _birthdateController.clear();
  }

  @override
  void initState() {
    super.initState();
    _patientsList = patientDataAccess.getPatientsByDoctorId(widget.doctor.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new patient',
        child: Icon(Icons.add),
        onPressed: () async {
          bool isRefreshNeeded = await showDialog(
            context: context,
            builder: (context) => GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
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
                        title: Text(
                          'New patient',
                        ),
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailTextFormField(
                                      controller: _firstNameController,
                                      validator: validateName,
                                      label: 'First name'),
                                  DetailTextFormField(
                                      controller: _lastNameController,
                                      validator: validateName,
                                      label: 'Last name'),
                                  DetailTextFormField(
                                      controller: _personalIdController,
                                      validator: validatePersonalId,
                                      label: 'PESEL'),
                                  DatePicker(
                                    controller: _birthdateController,
                                    validator: validateDate,
                                    label: 'Birthdate',
                                    onTap: () async {
                                      DateTime initialDate;
                                      if (_birthdateController.text == "") {
                                        initialDate = DateTime.now();
                                      } else {
                                        initialDate = DateTime.parse(
                                            _birthdateController.text);
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
                                            _birthdateController.text = picked
                                                .toIso8601String()
                                                .substring(0, 10);
                                          },
                                        );
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
                                        },
                                      ),
                                      IconButton(
                                        tooltip: 'Add',
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
                                                  birthdate:
                                                      _birthdateController
                                                          .text);

                                              var patientDataAccess =
                                                  DIContainer.getIt
                                                      .get<PatientDataAccess>();

                                              await patientDataAccess
                                                  .createPatient(patient);

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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
          if (isRefreshNeeded != null && isRefreshNeeded == true) refreshList();
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
                      //TODO: search bar

                      SizedBox(height: 20),
                      Expanded(
                        child: FutureBuilder(
                          future: _patientsList,
                          builder: (context, AsyncSnapshot snap) {
                            if (!snap.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Column(
                                children: [
                                  TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        searchedString = value;
                                      });
                                    },
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "Search",
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snap.data.length,
                                    itemBuilder: (context, index) {
                                      Patient patient = snap.data[index];
                                      return '${patient.firstName} ${patient.lastName}'
                                              .contains(searchedString)
                                          ? Card(
                                              color: Colors.grey[100],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: ListTile(
                                                leading: Icon(
                                                  FlutterIcons.account_mco,
                                                  size: 50,
                                                ),
                                                title: Text(
                                                  '${patient.firstName} ${patient.lastName}',
                                                ),
                                                subtitle: Text(patient
                                                    .personalId
                                                    .toString()),
                                                onTap: () async {
                                                  var medicationDataAccess =
                                                      DIContainer.getIt.get<
                                                          MedicationDataAccess>();

                                                  try {
                                                    List<Medication>
                                                        medications =
                                                        await medicationDataAccess
                                                            .getMedicationsByPatientId(
                                                                patient
                                                                    .personalId);

                                                    var isRefreshNeeded =
                                                        await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            WebPatientScreen(
                                                          patient: patient,
                                                          medications:
                                                              medications,
                                                          doctor: widget.doctor,
                                                        ),
                                                      ),
                                                    );

                                                    if (isRefreshNeeded !=
                                                            null &&
                                                        isRefreshNeeded ==
                                                            true) {
                                                      refreshList();
                                                    }
                                                  } catch (e) {
                                                    ErrorHandlingSnackbar.show(
                                                        e, context);
                                                  }
                                                },
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                ],
                              );
                            }
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
