import 'package:agri_guide_app/core/network/api_services.dart';
import 'package:agri_guide_app/feature/crop_recom/data/models/crop_model.dart';
import 'package:agri_guide_app/feature/crop_recom/domain/entity/crop_entity.dart';
import 'package:agri_guide_app/feature/crop_recom/domain/repos/crop_repo.dart';
import 'package:agri_guide_app/feature/home/data/models/soil_estimator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CropRepoImpl implements CropRepo {
  final _weatherApi = ApiServices(
    baseUrl: 'https://api.tomorrow.io/v4/',
  );

  final _cropApi = ApiServices(
    baseUrl: dotenv.env['DETECT_DISEASE_API']!,
  );
final weatherApikey=dotenv.env['WEATHER_APIKEY'];
  @override
  Future<List<CropEntity>> recommendCrop({
    required double lat,
    required double lon,
  }) async {

    final weatherData = await _weatherApi.get(
      'weather/forecast',
      query: {
        'location': '$lat,$lon',
        'apikey': weatherApikey,
      },
    );

    final values = weatherData['timelines']['hourly'][0]['values'];
    final temp = (values['temperature'] ?? 0).toDouble();
    final soilMoisture =
        (values['soilMoistureVolumetric0To10'] ?? 0).toDouble();
    final rainChance =
        (values['precipitationProbability'] ?? 0).toDouble();
    final humidity = (values['humidity'] ?? 0).toDouble();
    final rainfall = (values['rainAccumulation'] ?? 0).toDouble();

    final soilData = SoilEstimator.estimate(
      temperature: temp,
      soilMoisture: soilMoisture,
      rainChance: rainChance,
    );

    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        print('🌱 Attempt $attempt - Sending to crop API');
        print('🌱 soilData: $soilData');
        print('🌱 lat: $lat, lon: $lon');
        print('🌱 temp: $temp, humidity: $humidity, rainfall: $rainfall');

        final response = await _cropApi.post(
          'recommend-crop',
          data: {
            "N": soilData["N"],
            "P": soilData["P"],
            "K": soilData["K"],
            "ph": soilData["ph"],
            "latitude": lat,
            "longitude": lon,
            // "temperature": temp,
            // "humidity": humidity,
            // "rainfall": rainfall,
          },
        );
        final recommendations = response['recommendations'] as List;
        

        print('✅ Response: $recommendations');
        return recommendations.map((crop)=>CropModel.fromJson(crop)).toList();
      } catch (e) {
        print('❌ Attempt $attempt failed: $e');
        if (attempt == 3) rethrow;
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    throw Exception('Server unavailable');
  }
}