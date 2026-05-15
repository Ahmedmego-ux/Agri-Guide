import 'package:agri_guide_app/feature/crop_recom/domain/entity/crop_entity.dart';

abstract class CropRepo {
  Future<List< CropEntity>> recommendCrop({
    required double lat,
    required double lon,
  });
}