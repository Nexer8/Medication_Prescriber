import 'package:medication_prescriber/models/patient.dart';

abstract class IPatientDataAccess {
  Future<Patient> getPatientById(int patientId);

  Future<List<Patient>> getPatients();

  Future<void> createPatient(Patient patient);

  Future<void> editPatientData(Patient patient);

  Future<void> deletePatientById(int patientId);

  Future<List<Patient>> getPatientsByDoctorId(int doctorId);
}
