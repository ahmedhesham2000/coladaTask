import '../../domain/entities/working_hours.dart';

class WorkingHoursModel extends WorkingHours {
  const WorkingHoursModel({
    required super.opensAt,
    required super.closesAt,
    required super.label,
  });

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) {
    return WorkingHoursModel(
      opensAt: json['opensAt'] as String,
      closesAt: json['closesAt'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'opensAt': opensAt,
      'closesAt': closesAt,
      'label': label,
    };
  }
}
