// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return Patient(
    personalId: json['personalId'] as int,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    birthdate: json['birthdate'] as String,
  );
}

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'personalId': instance.personalId,
      'birthdate': instance.birthdate,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
