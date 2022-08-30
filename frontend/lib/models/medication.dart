import 'package:json_annotation/json_annotation.dart';

part 'medication.g.dart';

@JsonSerializable()
class Medication {
  int id;
  int patientId;
  int doctorId;
  String name;
  String startDate;
  String endDate;
  int dosage;
  String timing;

  Medication({
    this.id,
    this.patientId,
    this.doctorId,
    this.name,
    this.startDate,
    this.endDate,
    this.dosage,
    this.timing,
  });

  factory Medication.fromJson(Map<String, dynamic> json) =>
      _$MedicationFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationToJson(this);
}
