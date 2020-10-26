// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medication _$MedicationFromJson(Map<String, dynamic> json) {
  return Medication(
    json['id'] as int,
    json['patientId'] as int,
    json['doctorId'] as int,
    json['name'] as String,
    json['startDate'] as String,
    json['endDate'] as String,
    json['dosage'] as int,
    json['timing'] as String,
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
