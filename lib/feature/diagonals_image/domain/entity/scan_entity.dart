class ScanEntity {
 
    final String imageUrl;
  final String result;
  final DateTime date;
  final String userId;

  ScanEntity(  {
    required this.userId,
    required this.imageUrl,
   required this.result,
    required this.date
    });
}