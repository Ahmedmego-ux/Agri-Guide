class ApiErrors {
  final String message;
  final int? statusCode;

  ApiErrors({
    required this.message,
    this.statusCode,
  });

  // ✅ عشان لما يتعمل throw يظهر الـ message مش Instance of 'ApiErrors'
  @override
  String toString() => message;
}