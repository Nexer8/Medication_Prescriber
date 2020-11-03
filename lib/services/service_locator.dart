import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ptsiim/services/doctor_data_access.dart';
import 'package:ptsiim/services/medication_data_access.dart';
import 'package:ptsiim/services/patient_data_access.dart';

class DIContainer {
  static final GetIt getIt = GetIt.instance;

  static void registerServices() {
    getIt.registerLazySingleton(() => FlutterSecureStorage());
    getIt.registerLazySingleton(() => PatientDataAccess());
    getIt.registerLazySingleton(() => MedicationDataAccess());
    getIt.registerLazySingleton(() => DoctorDataAccess());
  }
}
