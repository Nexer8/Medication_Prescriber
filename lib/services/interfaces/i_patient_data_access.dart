import 'package:ptsiim/models/patient.dart';

abstract class IPatientDataAccess {
  Future<Patient> getPatientById(int patientId);

  Future<List<Patient>> getPatients();

  Future<Patient> createPatient(Patient patient);

  Future<Patient> editPatientData(Patient patient);

  Future<void> deletePatientById(int patientId);
}
