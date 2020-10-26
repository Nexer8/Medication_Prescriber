import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ptsiim/models/medication.dart';
import 'package:ptsiim/services/interfaces/i_medication_data_access.dart';
import 'package:ptsiim/utils/api_constants.dart';
import 'package:ptsiim/utils/custom_exceptions.dart';

class MedicationDataAccess implements IMedicationDataAccess {
  static final String medicationsUrl = apiUrl + medicationsEndpoint;

  @override
  Future<void> createMedication(Medication medication) async {
    print('DUPA');
    http.Response response = await http.post(
      medicationsUrl,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode(
        medication.toJson(),
      ),
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }
  }

  @override
  Future<void> editMedicationData(Medication medication) async {
    String urlToPut = medicationsUrl + '/${medication.id.toString()}';

    http.Response response = await http.put(
      urlToPut,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode(
        medication.toJson(),
      ),
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }
  }

  @override
  Future<Medication> getMedicationById(int medicationId) async {
    String urlToGet = medicationsUrl + '/${medicationId.toString()}';

    http.Response response = await http.get(
      urlToGet,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    Medication medication = Medication.fromJson(
      json.decode(response.body),
    );

    return medication;
  }

  @override
  Future<List<Medication>> getMedications() async {
    http.Response response = await http.get(
      medicationsUrl,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    var medicationsJsonList = json.decode(response.body) as List;
    List<Medication> medications = medicationsJsonList
        .map(
          (medicationJson) => Medication.fromJson(medicationJson),
        )
        .toList();

    return medications;
  }

  @override
  Future<List<Medication>> getMedicationsByPatientId(int patientId) async {
    String urlToGet = medicationsUrl + '/patient/${patientId.toString()}';

    http.Response response = await http.get(
      urlToGet,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    var medicationsJsonList = json.decode(response.body) as List;
    List<Medication> medications = medicationsJsonList
        .map(
          (medicationJson) => Medication.fromJson(medicationJson),
        )
        .toList();

    return medications;
  }

  @override
  Future<List<Medication>> getMedicationsByDoctorId(int doctorId) async {
    String urlToGet = medicationsUrl + '/doctor/${doctorId.toString()}';

    http.Response response = await http.get(
      urlToGet,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    var medicationsJsonList = json.decode(response.body) as List;
    List<Medication> medications = medicationsJsonList
        .map(
          (medicationJson) => Medication.fromJson(medicationJson),
        )
        .toList();

    return medications;
  }

  @override
  Future<void> deleteMedicationById(int medicationId) async {
    String urlToDelete = medicationsUrl + '/${medicationId.toString()}';

    http.Response response = await http.delete(
      urlToDelete,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }
  }

  @override
  Future<List<Medication>> getMedicationsByPatientIdAndDate(
      int patientId, DateTime date) async {
    String urlToGet = medicationsUrl +
        '/patient/${patientId.toString()}?date=${date.toIso8601String()}';

    http.Response response = await http.get(
      urlToGet,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    var medicationsJsonList = json.decode(response.body) as List;
    List<Medication> medications = medicationsJsonList
        .map(
          (medicationJson) => Medication.fromJson(medicationJson),
        )
        .toList();

    return medications;
  }
}
