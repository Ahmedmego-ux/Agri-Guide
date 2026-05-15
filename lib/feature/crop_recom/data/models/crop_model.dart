import 'package:agri_guide_app/feature/crop_recom/domain/entity/crop_entity.dart';

class CropModel extends CropEntity{
  CropModel({required super.crop, required super.cropAr, required super.descriptionAr, required super.description});
  

   factory CropModel.fromJson(Map<String,dynamic>json){
    return CropModel(
      crop: json["recommended_crop"],
       description:json['description'],
        cropAr: json['recommended_crop_ar'],
         descriptionAr: json['description_ar'],
        );
  }

 
}