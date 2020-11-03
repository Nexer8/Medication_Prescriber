import 'package:flutter/material.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/screens/web/welcome_screen.dart';

class DoctorPanel extends StatelessWidget {
  DoctorPanel({@required this.doctor, @required this.content});

  final Doctor doctor;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => SafeArea(
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
                      doctor.firstName,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[100],
                      ),
                    ),
                    Text(
                      doctor.lastName,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[100],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      doctor.specialization,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[100],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      tooltip: 'Logout',
                      icon:
                          Icon(Icons.logout, size: 35, color: Colors.grey[100]),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebWelcomeScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
