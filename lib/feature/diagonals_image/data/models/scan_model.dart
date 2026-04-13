import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';

class ScanModel extends ScanEntity {

  ScanModel( {required super.imageUrl,
   required super.result,
    required super.date, 
    required super.userId});

factory ScanModel.fromJson(Map<String,dynamic>json){
  return ScanModel(
    imageUrl: json['image_url'],
     result: json['result'],
      date: DateTime.parse(json['created_at']),
       userId: 'user_id');
}
Map<String,dynamic>toJson(){
  return {
    'image_url':imageUrl,
    'result':result,
    'created_at':date.toIso8601String(),
    'user_id':userId,
  };
}
}