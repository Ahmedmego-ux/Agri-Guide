import 'dart:io';

import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';

abstract class ScanRepo {
  Future<String>imageUrl(File file);
   Future<ScanEntity> detectDisease(File file);
  Future<void>saveScane({required File file,});
  Future<List<ScanEntity>> getHistory();
}