import 'package:ptsiim/models/medication.dart';

abstract class IMedicationDataAccess {
  Future<Medication> getMedicationById(int medicationId);

  Future<List<Medication>> getMedications();

  Future<Medication> createMedication(Medication medication);

  Future<Medication> editMedicationData(Medication medication);

  Future<List<Medication>> getMedicationsByPatientId(int patientId);

  Future<List<Medication>> getMedicationsByDoctorId(int doctorId);

  Future<void> deleteMedicationById(int medicationId);

  Future<List<Medication>> getMedicationsByPatientIdAndDate(
      int patientId, DateTime date);
}
