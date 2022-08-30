import 'package:medication_prescriber/models/medication.dart';

abstract class IMedicationDataAccess {
  Future<Medication> getMedicationById(int medicationId);

  Future<List<Medication>> getMedications();

  Future<void> createMedication(Medication medication);

  Future<void> editMedicationData(Medication medication);

  Future<List<Medication>> getMedicationsByPatientId(int patientId);

  Future<List<Medication>> getMedicationsByDoctorId(int doctorId);

  Future<void> deleteMedicationById(int medicationId);

  Future<List<Medication>> getMedicationsByPatientIdAndDate(
      int patientId, DateTime date);
}
