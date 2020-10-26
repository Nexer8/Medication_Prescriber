import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ptsiim/models/doctor.dart';
import 'package:ptsiim/services/interfaces/i_doctor_data_access.dart';
import 'package:ptsiim/utils/api_constants.dart';
import 'package:ptsiim/utils/custom_exceptions.dart';

class DoctorDataAccess implements IDoctorDataAccess {
  static final String doctorsUrl = apiUrl + doctorsEndpoint;

  @override
  Future<Doctor> getDoctorById(int doctorId) async {
    String urlToGet = doctorsUrl + '/${doctorId.toString()}';

    print(urlToGet);
    http.Response response = await http.get(
      urlToGet,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    print(response.statusCode);

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    Doctor doctor = Doctor.fromJson(
      json.decode(response.body),
    );

    return doctor;
  }

  @override
  Future<List<Doctor>> getDoctors() async {
    http.Response response = await http.get(
      doctorsUrl,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    var doctorsJsonList = json.decode(response.body) as List;
    List<Doctor> doctors = doctorsJsonList
        .map(
          (doctorJson) => Doctor.fromJson(doctorJson),
        )
        .toList();

    return doctors;
  }

  @override
  Future<Doctor> createDoctor(Doctor doctor) async {
    http.Response response = await http.post(
      doctorsUrl,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode(
        doctor.toJson(),
      ),
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }

    Doctor createdDoctor = Doctor.fromJson(json.decode(response.body));

    return createdDoctor;
  }

  @override
  Future<void> deleteDoctorById(int doctorId) async {
    String urlToDelete = doctorsUrl + '/${doctorId.toString()}';

    http.Response response = await http.delete(
      urlToDelete,
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw HttpException(response.statusCode);
    }
  }
}
