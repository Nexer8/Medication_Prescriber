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
import 'package:ptsiim/services/service_locator.dart';

class MobileHomeScreen extends StatefulWidget {
  final Patient patient;
  final List<Medication> medications;

  MobileHomeScreen({@required this.patient, @required this.medications});

  @override
  _MobileHomeScreenState createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                          Text(
                            'Your plan for today:\n${widget.medications.length} medicines',
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 16,
                            ),
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
                    'Daily review:',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                          leading: Icon(
                            MaterialCommunityIcons.pill,
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            size: 50,
                          ),
                          title: Text(
                            widget.medications[index].name,
                            style: TextStyle(
                              color: Colors.grey[800],
                            ),
                          ),
                          subtitle: Text(
                            'Dosage: ${widget.medications[index].dosage.toString()} Timing: ${widget.medications[index].timing}',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey[600],
                          ),
                          onTap: () async {
                            var doctorDataAccess =
                                DIContainer.getIt.get<DoctorDataAccess>();

                            try {
                              Doctor doctor =
                                  await doctorDataAccess.getDoctorById(
                                      widget.medications[index].doctorId);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MobileMedicationScreen(
                                      doctor: doctor,
                                      medication: widget.medications[index]),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
