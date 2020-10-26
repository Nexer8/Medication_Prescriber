import 'package:ptsiim/models/patient.dart';

abstract class IPatientDataAccess {
  Future<Patient> getPatientById(int patientId);

  Future<List<Patient>> getPatients();

  Future<void> createPatient(Patient patient);

  Future<void> editPatientData(Patient patient, {int newId});

  Future<void> deletePatientById(int patientId);

  Future<List<Patient>> getPatientsByDoctorId(int doctorId);
}
