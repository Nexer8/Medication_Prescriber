import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  int id;
  String specialization;
  String firstName;
  String lastName;

  Doctor({this.id, this.firstName, this.lastName, this.specialization});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
