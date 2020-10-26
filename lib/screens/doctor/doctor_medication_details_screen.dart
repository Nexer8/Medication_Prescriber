import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/models/medication.dart';

class DoctorMedicationDetailsScreen extends StatefulWidget {
  final Medication medication;

  DoctorMedicationDetailsScreen({@required this.medication});

  @override
  _DoctorMedicationDetailsScreenState createState() =>
      _DoctorMedicationDetailsScreenState();
}

class _DoctorMedicationDetailsScreenState
    extends State<DoctorMedicationDetailsScreen> {
  TextEditingController _nameController;

  TextEditingController _startDateController;

  TextEditingController _endDateController;

  TextEditingController _dosageController;

  TextEditingController _timingController;

  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medication.name);
    _startDateController =
        TextEditingController(text: widget.medication.startDate);
    _endDateController = TextEditingController(text: widget.medication.endDate);
    _dosageController =
        TextEditingController(text: widget.medication.dosage.toString());
    _timingController = TextEditingController(text: widget.medication.timing);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
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
                            child: Image.asset('assets/details.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.25)),
                        SizedBox(height: 10),
                        Text(
                          'Personal id',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        Text(
                          widget.medication.patientId.toString(),
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[800]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Doctor name',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        //TODO:
                        Text('dWa ame}',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('Name',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _nameController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('Start date',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _startDateController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('End date',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _endDateController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('Dosage',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _dosageController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        SizedBox(height: 10),
                        Text('Timing',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600])),
                        TextFormField(
                            controller: _timingController,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800])),
                        Spacer(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  iconSize: 42,
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    //TODO: delete patient (simple dialog?)
                                  }),
                              IconButton(
                                  iconSize: 42,
                                  icon: Icon(Icons.save, color: Colors.blue),
                                  onPressed: () {
                                    //TODO: save
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
