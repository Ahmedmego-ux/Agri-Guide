class ScanEntity {
  final String imageUrl;

  final String predictedClass;
  final double confidence;

  final String cause;
  final String causeAr;

  final String symptoms;
  final String symptomsAr;

  final String treatment;
  final String treatmentAr;

  final String prevention;
  final String preventionAr;

  final bool isHealthy;

  final DateTime date;
  final String userId;

  ScanEntity({
    required this.imageUrl,
    required this.predictedClass,
    required this.confidence,
    required this.cause,
    required this.causeAr,
    required this.symptoms,
    required this.symptomsAr,
    required this.treatment,
    required this.treatmentAr,
    required this.prevention,
    required this.preventionAr,
    required this.isHealthy,
    required this.date,
    required this.userId,
  });
}