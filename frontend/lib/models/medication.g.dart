// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medication _$MedicationFromJson(Map<String, dynamic> json) {
  return Medication(
    id: json['id'] as int,
    patientId: json['patientId'] as int,
    doctorId: json['doctorId'] as int,
    name: json['name'] as String,
    startDate: json['startDate'] as String,
    endDate: json['endDate'] as String,
    dosage: json['dosage'] as int,
    timing: json['timing'] as String,
  );
}

Map<String, dynamic> _$MedicationToJson(Medication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'doctorId': instance.doctorId,
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'dosage': instance.dosage,
      'timing': instance.timing,
    };
