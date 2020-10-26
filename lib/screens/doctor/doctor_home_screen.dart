import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/screens/doctor/doctor_patient_details_screen.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';

import 'doctor_welcome_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  final Doctor doctor;
  final List<Patient> patients;

  const DoctorHomeScreen({Key key, this.doctor, this.patients})
      : super(key: key);

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final _searchController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _personalIdController = TextEditingController();
  final _birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new patient',
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              contentPadding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              title: Text('New patient'),
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: 350,
                    width: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: _firstNameController,
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
                              hintText: "First name",
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: _lastNameController,
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
                              hintText: "Last name",
                            ),
                          ),
                          //SizedBox(height: 20),
                          SizedBox(height: 30),
                          TextField(
                            controller: _personalIdController,
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
                              hintText: "Personal ID",
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: _birthdateController,
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
                              hintText: "Birthdate (DD/MM/YYYY)",
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
                                      Patient patient;
                                      patient.personalId =
                                          int.parse(_personalIdController.text);
                                      patient.firstName =
                                          _firstNameController.text;
                                      patient.lastName =
                                          _firstNameController.text;
                                      patient.birthdate =
                                          _birthdateController.text;

                                      var patientDataAccess = DIContainer.getIt
                                          .get<PatientDataAccess>();

                                      await patientDataAccess
                                          .createPatient(patient);

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
                ),
              ],
            ),
          );
        },
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[100],
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    Icon(
                      Icons.account_circle_rounded,
                      size: 120,
                      color: Colors.grey[100],
                    ),
                    Text(
                      widget.doctor.firstName,
                      style: TextStyle(fontSize: 24, color: Colors.grey[100]),
                    ),
                    Text(
                      widget.doctor.lastName,
                      style: TextStyle(fontSize: 24, color: Colors.grey[100]),
                    ),
                    Text(
                      widget.doctor.specialization,
                      style: TextStyle(fontSize: 22, color: Colors.grey[100]),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.logout,
                            size: 40, color: Colors.grey[100]),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorWelcomeScreen(),
                            ),
                          );
                        }),
                    SizedBox(height: 80),
                  ],
                ),
              ),
              Expanded(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Patients',
                            style: TextStyle(
                                fontSize: 42, color: Colors.grey[800]),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey[800]),
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
                              hintText: "Search...",
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
                                        leading: Icon(FlutterIcons.account_mco,
                                            size: 50),
                                        title: Text(
                                            '${widget.patients[index].firstName} ${widget.patients[index].lastName}'),
                                        subtitle: Text(widget
                                            .patients[index].personalId
                                            .toString()),
                                        onTap: () async {
                                          var medicationDataAccess = DIContainer
                                              .getIt
                                              .get<MedicationDataAccess>();

                                          List<Medication> medications =
                                              await medicationDataAccess
                                                  .getMedicationsByPatientId(
                                                      widget.patients[index]
                                                          .personalId);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorPatientDetailsScreen(
                                                patient: widget.patients[index],
                                                medications: medications,
                                                doctor: widget.doctor,
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
