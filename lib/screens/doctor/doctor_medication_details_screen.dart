import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/components/detail_edit_text.dart';
import 'package:ptsiim/components/detail_text.dart';
import 'package:ptsiim/components/doctor_panel.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/input_validators.dart';
import 'package:recase/recase.dart';

class DoctorMedicationDetailsScreen extends StatefulWidget {
  final Medication medication;
  final Doctor doctor;

  DoctorMedicationDetailsScreen({@required this.medication, this.doctor});

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
  final _formKey = GlobalKey<FormState>();
  String _timing;

  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medication.name);
    _startDateController =
        TextEditingController(text: widget.medication.startDate);
    _endDateController = TextEditingController(text: widget.medication.endDate);
    _dosageController =
        TextEditingController(text: widget.medication.dosage.toString());
    _timing = widget.medication.timing.sentenceCase;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Form(
          key: _formKey,
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
                              child: Image.asset('assets/details.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.25)),
                          SizedBox(height: 12),
                          DetailText(
                            label: 'PESEL',
                            data: widget.medication.patientId.toString(),
                          ),
                          DetailText(
                            label: 'Doctor name',
                            data:
                                '${widget.doctor.firstName} ${widget.doctor.lastName}',
                          ),
                          DetailEditText(
                            label: 'Name',
                            controller: _nameController,
                            validator: validateName,
                          ),
                          DetailEditText(
                            label: 'Dosage',
                            controller: _dosageController,
                            validator: validateDosage,
                          ),
                          Text(
                            'Timing',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                _timing,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[800],
                                ),
                              ),
                              value: _timing,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[800],
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  _timing = newValue;
                                });
                              },
                              items: <String>[
                                'Irrelevant',
                                'Before eating',
                                'After eating'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value.pascalCase,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[800]),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  iconSize: 42,
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    var medicationDataAccess = DIContainer.getIt
                                        .get<MedicationDataAccess>();

                                    try {
                                      await medicationDataAccess
                                          .deleteMedicationById(
                                              widget.medication.id);

                                      Navigator.pop(context);
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
                                    }
                                  }),
                              IconButton(
                                iconSize: 42,
                                icon: Icon(Icons.save, color: Colors.blue),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    widget.medication.name = _nameController.text;
                                    widget.medication.startDate =
                                        _startDateController.text;
                                    widget.medication.endDate =
                                        _endDateController.text;
                                    widget.medication.dosage =
                                        int.parse(_dosageController.text);
                                    widget.medication.timing = _timing;

                                    var medicationDataAccess = DIContainer.getIt
                                        .get<MedicationDataAccess>();

                                    try {
                                      await medicationDataAccess
                                          .editMedicationData(widget.medication);

                                      Navigator.pop(context);
                                    } catch (e) {
                                      ErrorHandlingSnackbar.show(e, context);
                                    }
                                  }
                                },
                              ),
                            ],
                          )
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
