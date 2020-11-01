import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsiim/components/detail_edit_text.dart';
import 'package:ptsiim/components/detail_text.dart';
import 'package:ptsiim/components/doctor_panel.dart';
import 'package:ptsiim/components/edit_date_picker.dart';
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
  TextEditingController _dosageController;
  final _formKey = GlobalKey<FormState>();
  String _timing;

  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medication.name);
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
                                  height: MediaQuery.of(context).size.height *
                                      0.25)),
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
                          EditDatePicker(
                            date: widget.medication.startDate,
                            label: 'Start date',
                            onTap: () async {
                              DateTime initialDate =
                                  DateTime.parse(widget.medication.startDate);
                              DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: initialDate,
                                firstDate: DateTime(1920),
                                lastDate: DateTime(2050),
                              );
                              if (picked != null && picked != initialDate)
                                setState(
                                  () {
                                    initialDate = picked;
                                    widget.medication.startDate =
                                        picked.toIso8601String();
                                  },
                                );
                            },
                          ),
                          EditDatePicker(
                            date: widget.medication.endDate,
                            label: 'End date',
                            onTap: () async {
                              DateTime initialDate =
                                  DateTime.parse(widget.medication.endDate);
                              DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: initialDate,
                                firstDate: DateTime(1920),
                                lastDate: DateTime(2050),
                              );
                              if (picked != null && picked != initialDate)
                                setState(
                                  () {
                                    initialDate = picked;
                                    widget.medication.endDate =
                                        picked.toIso8601String();
                                  },
                                );
                            },
                          ),
                          DropdownButtonFormField<String>(
                            isDense: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            hint: Text(
                              _timing,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[800],
                              ),
                            ),
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
                              'BeforeEating',
                              'AfterEating'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value.sentenceCase,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[800]),
                                ),
                              );
                            }).toList(),
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
                                    widget.medication.name =
                                        _nameController.text;
                                    widget.medication.dosage =
                                        int.parse(_dosageController.text);
                                    widget.medication.timing =
                                        _timing.pascalCase;

                                    var medicationDataAccess = DIContainer.getIt
                                        .get<MedicationDataAccess>();

                                    try {
                                      await medicationDataAccess
                                          .editMedicationData(
                                              widget.medication);
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
