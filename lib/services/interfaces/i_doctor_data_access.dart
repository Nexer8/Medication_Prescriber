import 'package:ptsiim/models/doctor.dart';

abstract class IDoctorDataAccess {
  Future<List<Doctor>> getDoctors();

  Future<Doctor> getDoctorById(int doctorId);

  Future<void> deleteDoctorById(int doctorId);

  Future<Doctor> createDoctor(Doctor doctor);
}
