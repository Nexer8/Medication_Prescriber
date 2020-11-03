import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/screens/mobile/medication_screen.dart';
import 'package:ptsiim/screens/mobile/profile_screen.dart';
import 'package:ptsiim/screens/mobile/welcome_screen.dart';
import 'package:ptsiim/services/doctor_data_access.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/style_constants.dart';
import 'package:recase/recase.dart';

class MobileHomeScreen extends StatefulWidget {
  final Patient patient;

  MobileHomeScreen({@required this.patient});

  @override
  _MobileHomeScreenState createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  var medicationDataAccess = DIContainer.getIt.get<MedicationDataAccess>();

  Future<List<Medication>> _medicationsList;

  Future<Null> refreshList() async {
    setState(() {
      _medicationsList = medicationDataAccess.getMedicationsByPatientIdAndDate(
          widget.patient.personalId, DateTime.now());
    });
  }

  void initState() {
    super.initState();
    _medicationsList = medicationDataAccess.getMedicationsByPatientIdAndDate(
        widget.patient.personalId, DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.grey[800],
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MobileWelcomeScreen(),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.grey[800],
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MobileProfileScreen(patient: widget.patient),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,\n${widget.patient.firstName}!',
                              style: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 34,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Nice to see you :)',
                              style: TextStyle(
                                color: Colors.grey[100],
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20),
                            FutureBuilder(
                              future: _medicationsList,
                              builder: (context, AsyncSnapshot snap) {
                                if (!snap.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Text(
                                    'Your plan for today:\n${snap.data.length} medicines',
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                      fontSize: 16,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image.asset('assets/drugs.png'),
                      ),
                    ]),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Daily review',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder(
                      future: _medicationsList,
                      builder: (context, AsyncSnapshot snap) {
                        if (!snap.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snap.data.length,
                            itemBuilder: (context, index) {
                              Medication medication = snap.data[index];
                              return Card(
                                color: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    MaterialCommunityIcons.pill,
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    size: 50,
                                  ),
                                  title: Text(
                                    medication.name,
                                    style: kContentTextStyle,
                                  ),
                                  subtitle: Text(
                                    'Dosage: ${medication.dosage.toString()} Timing: ${medication.timing.sentenceCase}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  trailing: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey[600],
                                  ),
                                  onTap: () async {
                                    var doctorDataAccess = DIContainer.getIt
                                        .get<DoctorDataAccess>();

                                    try {
                                      Doctor doctor = await doctorDataAccess
                                          .getDoctorById(medication.doctorId);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MobileMedicationScreen(
                                                  doctor: doctor,
                                                  medication: medication),
                                        ),
                                      );
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
                                    }
                                  },
                                ),
                              );
                            },
                          );
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
    );
  }
}
