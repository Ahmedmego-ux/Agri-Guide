import 'dart:io';

import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/core/network/api_services.dart';
import 'package:agri_guide_app/feature/diagonals_image/data/models/scan_model.dart';
import 'package:agri_guide_app/feature/diagonals_image/domain/entity/scan_entity.dart';
import 'package:agri_guide_app/feature/diagonals_image/domain/repos/scan_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide MultipartFile;

class ScanImpl implements ScanRepo {
  final _supabase = Supabase.instance.client;
  final detectDiseaseUrl = dotenv.env['DETECT_DISEASE_API']!;

  @override
  Future<String> imageUrl(File file) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      await _supabase.storage
          .from('images')
          .upload(fileName, file);

      final publicUrl = _supabase.storage
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
  Future<void> saveScane({required File file}) async {
    try {
      final userId = _supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception("User not logged in");
      }

      final results = await Future.wait([
        imageUrl(file),
        detectDisease(file),
      ]);

      final imageUrlValue = results[0] as String;
      final disease = results[1] as ScanEntity;

      final model = ScanModel(
        imageUrl: imageUrlValue,

        predictedClass: disease.predictedClass,
        confidence: disease.confidence,

        cause: disease.cause,
        causeAr: disease.causeAr,

        symptoms: disease.symptoms,
        symptomsAr: disease.symptomsAr,

        treatment: disease.treatment,
        treatmentAr: disease.treatmentAr,

        prevention: disease.prevention,
        preventionAr: disease.preventionAr,

        isHealthy: disease.isHealthy,

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
          .select()
          .eq('user_id', userId!)
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

  @override
  Future<ScanEntity> detectDisease(File file) async {
    try {
      final formdata = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });

      final response = await ApiServices(
        baseUrl: detectDiseaseUrl,
      ).postForm('detect-disease', formdata);

      print("API RESPONSE: $response");

      return ScanEntity(
        imageUrl: '',

        predictedClass: response['predicted_class'] ?? '',
        confidence: ((response['confidence'] ?? 0) as num).toDouble() / 100,

        cause: response['cause'] ?? '',
        causeAr: response['cause_ar'] ?? '',

        symptoms: response['symptoms'] ?? '',
        symptomsAr: response['symptoms_ar'] ?? '',

        treatment: response['treatment'] ?? '',
        treatmentAr: response['treatment_ar'] ?? '',

        prevention: response['prevention'] ?? '',
        preventionAr: response['prevention_ar'] ?? '',

        isHealthy: response['is_healthy'] ?? false,

        date: DateTime.now(),
        userId: '',
      );
    } catch (e) {
      throw Exception(
        ErrorHandler.handlePostgrestError(e.toString()),
      );
    }
  }
}