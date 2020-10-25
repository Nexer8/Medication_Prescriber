import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ptsiim/models/patient.dart';
import 'package:ptsiim/utils/api_constants.dart';
import 'package:ptsiim/utils/custom_exceptions.dart';

import 'interfaces/i_patient_data_access.dart';

class PatientDataAccess implements IPatientDataAccess {
  static final String patientsUrl = apiUrl + patientsEndpoint;

  @override
  Future<Patient> createPatient(Patient patient) async {
    http.Response response = await http.post(
      patientsUrl,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode(
        patient.toJson(),
      ),
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    Patient createdPatient = Patient.fromJson(json.decode(response.body));

    return createdPatient;
  }

  @override
  Future<Patient> editPatientData(Patient patient) async {
    String urlToPut = patientsUrl + '/${patient.personalId.toString()}';

    http.Response response = await http.put(
      urlToPut,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode(
        patient.toJson(),
      ),
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    Patient editedPatient = Patient.fromJson(json.decode(response.body));

    return editedPatient;
  }

  @override
  Future<Patient> getPatientById(int patientId) async {
    String urlToGet = patientsUrl + '/${patientId.toString()}';

    http.Response response =
        await http.get(urlToGet, headers: {'accept': 'application/json'});

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    Patient patient = Patient.fromJson(json.decode(response.body));

    return patient;
  }

  @override
  Future<List<Patient>> getPatients() async {
    http.Response response =
        await http.get(patientsUrl, headers: {'accept': 'application/json'});

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    var patientsJsonList = json.decode(response.body) as List;
    List<Patient> patients = patientsJsonList
        .map((patientJson) => Patient.fromJson(patientJson))
        .toList();

    return patients;
  }

  @override
  Future<void> deletePatientById(int patientId) async {
    String urlToDelete = patientsUrl + '/${patientId.toString()}';

    http.Response response =
        await http.delete(urlToDelete, headers: {'accept': 'application/json'});

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }
  }

  Future<List<Patient>> getPatientsByDoctorId(int doctorId) async {
    String urlToGet = patientsUrl + '?$doctorId';

    http.Response response =
        await http.get(urlToGet, headers: {'accept': 'application/json'});

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    var patientsJsonList = json.decode(response.body) as List;
    List<Patient> patients = patientsJsonList
        .map((patientJson) => Patient.fromJson(patientJson))
        .toList();

    return patients;
  }
}
