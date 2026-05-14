import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';

class ScanModel extends ScanEntity {
  ScanModel({
    required super.imageUrl,
    required super.predictedClass,
    required super.confidence,
    required super.cause,
    required super.causeAr,
    required super.symptoms,
    required super.symptomsAr,
    required super.treatment,
    required super.treatmentAr,
    required super.prevention,
    required super.preventionAr,
    required super.isHealthy,
    required super.date,
    required super.userId,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) {
    return ScanModel(
      imageUrl: json['image_url'] ?? '',

      predictedClass: json['predicted_class'] ?? '',

      confidence: ((json['confidence'] ?? 0) as num).toDouble(),

      cause: json['cause'] ?? '',
      causeAr: json['cause_ar'] ?? '',

      symptoms: json['symptoms'] ?? '',
      symptomsAr: json['symptoms_ar'] ?? '',

      treatment: json['treatment'] ?? '',
      treatmentAr: json['treatment_ar'] ?? '',

      prevention: json['prevention'] ?? '',
      preventionAr: json['prevention_ar'] ?? '',

      isHealthy: json['is_healthy'] ?? false,

      date: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),

      userId: json['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,

      'predicted_class': predictedClass,

      'confidence': confidence,

      'cause': cause,
      'cause_ar': causeAr,

      'symptoms': symptoms,
      'symptoms_ar': symptomsAr,

      'treatment': treatment,
      'treatment_ar': treatmentAr,

      'prevention': prevention,
      'prevention_ar': preventionAr,

      'is_healthy': isHealthy,

      'created_at': date.toIso8601String(),

      'user_id': userId,
    };
  }
}