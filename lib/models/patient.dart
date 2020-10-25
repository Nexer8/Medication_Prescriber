import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  int personalId;
  String birthdate;
  String firstName;
  String lastName;

  Patient(this.personalId, this.firstName, this.lastName, this.birthdate);

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
