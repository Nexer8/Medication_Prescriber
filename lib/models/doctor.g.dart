// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  return Doctor(
    json['id'] as int,
    json['firstName'] as String,
    json['lastName'] as String,
    json['specialization'] as String,
  );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'specialization': instance.specialization,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
