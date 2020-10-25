import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/patient.dart';

class DoctorHomeScreen extends StatefulWidget {
  final Doctor doctor;
  final List<Patient> patients;

  const DoctorHomeScreen({Key key, this.doctor, this.patients})
      : super(key: key);

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0))),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.account_circle_rounded,
                      size: 120,
                      color: Colors.grey[100],
                    ),
                    Text('First name',
                        style:
                            TextStyle(fontSize: 24, color: Colors.grey[100])),
                    Text(
                      'Last name',
                      style: TextStyle(fontSize: 24, color: Colors.grey[100]),
                    ),
                    Text('Spec',
                        style:
                            TextStyle(fontSize: 22, color: Colors.grey[100])),
                    SizedBox(height: 80),
                    IconButton(
                      icon:
                          Icon(Icons.people, size: 40, color: Colors.grey[100]),
                      onPressed: () {},
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(FontAwesome5Solid.pills,
                            size: 40, color: Colors.grey[100]),
                        onPressed: () {}),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.logout,
                            size: 40, color: Colors.grey[100]),
                        onPressed: () {}),
                    SizedBox(height: 80),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('Dupad dupa'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
