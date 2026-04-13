import 'dart:io';

import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/feature/diagonals_image/data/models/scan_model.dart';
import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';
import 'package:agri_guide_app/feature/diagonals_image/domain/repos/scan_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScanImpl implements ScanRepo {
  final _supabase = Supabase.instance.client;
 


  @override
  Future<String> imageUrl(File file) async {
    try {
      final fileName =
          DateTime.now().millisecondsSinceEpoch.toString();

      await _supabase.storage
          .from('images')
          .upload(fileName, file);

      final publicUrl = _supabase
          .storage
          .from('images')
          .getPublicUrl(fileName);
          

      return publicUrl;
    } catch (e) {
         print("SCAN ERROR: $e");

      throw Exception(
        ErrorHandler.handlePostgrestError(e.toString()),
      );
    }
  }


  @override
  Future<void> saveScane({
    required File file,
    required String result,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      final imageUrlValue = await imageUrl(file);
if (userId == null) {
  throw Exception("User not logged in");
}
      final model = ScanModel(
        imageUrl: imageUrlValue,
        result: result,
        date: DateTime.now(),
        userId: userId,
      );

      await _supabase.from('scans').insert(model.toJson());
    } catch (e) {
         print("SCAN ERROR: $e");

      throw Exception(
        ErrorHandler.handlePostgrestError(e.toString()),
      );
    }
  }


  @override
  Future<List<ScanEntity>> getHistory() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      final data = await _supabase
          .from('scans')
          .select() .eq('user_id', userId!)
          .order('created_at', ascending: false);

      return (data as List)
          .map((e) => ScanModel.fromJson(e))
          .toList();
    } catch (e) {
         print("SCAN ERROR: $e");

      throw Exception(
        ErrorHandler.handlePostgrestError(e.toString()),
      );
    }
  }
}