import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:medication_prescriber/services/doctor_data_access.dart';
import 'package:medication_prescriber/services/medication_data_access.dart';
import 'package:medication_prescriber/services/patient_data_access.dart';

class DIContainer {
  static final GetIt getIt = GetIt.instance;

  static void registerServices() {
    getIt.registerLazySingleton(() => FlutterSecureStorage());
    getIt.registerLazySingleton(() => PatientDataAccess());
    getIt.registerLazySingleton(() => MedicationDataAccess());
    getIt.registerLazySingleton(() => DoctorDataAccess());
  }
}
