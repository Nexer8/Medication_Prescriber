import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'doctor_home_screen.dart';

class DoctorWelcomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _IdController = TextEditingController();

  @override
  void dispose() {
    _IdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Medication prescriber',
                        style: TextStyle(
                            color: Colors.grey[100],
                            fontSize: 80,
                            fontWeight: FontWeight.bold)),
                    Text('System management for doctors',
                        style: TextStyle(
                            color: Colors.grey[100],
                            fontSize: 42,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Icon(
                      FlutterIcons.capsules_faw5s,
                      color: Colors.grey[100],
                      size: 400,
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 550,
                      child: TextFormField(
                        controller: _IdController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter ID';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.green[300],
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(24.0, 2.0, 2.0, 0.0),
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
                          hintText: "Please enter your doctor ID",
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.grey[100],
                      textColor: Colors.grey[800],
                      child: Text(
                        'Login'.toUpperCase(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide.none,
                      ),
                      onPressed: () {
                        //TODO: Auth
                        if (_formKey.currentState.validate())
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorHomeScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
