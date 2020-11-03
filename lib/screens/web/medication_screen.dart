import 'package:flutter/material.dart';
import 'package:ptsiim/components/date_picker.dart';
import 'package:ptsiim/components/detail_text.dart';
import 'package:ptsiim/components/detail_text_form_field.dart';
import 'package:ptsiim/components/doctor_panel.dart';
import 'package:ptsiim/components/drop_down_button.dart';
import 'package:ptsiim/components/error_handling_snackbar.dart';
import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/service_locator.dart';
import 'package:ptsiim/utils/api_constants.dart';
import 'package:ptsiim/utils/input_validators.dart';
import 'package:recase/recase.dart';

class WebMedicationScreen extends StatefulWidget {
  final Medication medication;
  final Doctor doctor;

  WebMedicationScreen({@required this.medication, this.doctor});

  @override
  _WebMedicationScreenState createState() => _WebMedicationScreenState();
}

class _WebMedicationScreenState extends State<WebMedicationScreen> {
  TextEditingController _nameController;
  TextEditingController _dosageController;
  TextEditingController _startDateController;
  TextEditingController _endDateController;
  String _timing;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medication.name);
    _dosageController =
        TextEditingController(text: widget.medication.dosage.toString());
    _timing = widget.medication.timing.sentenceCase;
    _startDateController = TextEditingController(
        text: widget.medication.startDate.substring(0, 10));
    _endDateController =
        TextEditingController(text: widget.medication.endDate.substring(0, 10));
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
                          DetailTextFormField(
                            label: 'Name',
                            controller: _nameController,
                            validator: validateMedicationName,
                          ),
                          DetailTextFormField(
                            label: 'Dosage',
                            controller: _dosageController,
                            validator: validateDosage,
                          ),
                          DatePicker(
                            controller: _startDateController,
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
                                    _startDateController.text = picked
                                        .toIso8601String()
                                        .substring(0, 10);
                                    widget.medication.startDate =
                                        picked.toIso8601String();
                                  },
                                );
                            },
                          ),
                          DatePicker(
                            controller: _endDateController,
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
                                    _endDateController.text = picked
                                        .toIso8601String()
                                        .substring(0, 10);
                                    widget.medication.endDate = picked
                                            .toIso8601String()
                                            .substring(0, 10) +
                                        endDateTime;
                                  },
                                );
                            },
                          ),
                          DropDownButton(
                            timing: _timing,
                            onChanged: (String newValue) {
                              setState(() {
                                _timing = newValue;
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  tooltip: 'Delete',
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
                                tooltip: 'Save',
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
