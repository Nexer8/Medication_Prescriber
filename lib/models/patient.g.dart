// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    json['personalId'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['birthdate'] as String,
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'personalId': instance.personalId,
      'birthdate': instance.birthdate,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
