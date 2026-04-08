// weather_model.dart
import 'package:agri_guide_app/feature/home/domain/entityes/weather_entity.dart';
import 'package:agri_guide_app/feature/home/presentation/enums/weather_enum.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.temperature,
    required super.windSpeed,
    required super.rainChance,
    required super.uvIndex,
    required super.soilMoisture,
    required super.condition,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final values = json['timelines']['hourly'][0]['values'];

    final double temp = (values['temperature'] ?? 0).toDouble();
    final double windSpeed = (values['windSpeed'] ?? 0).toDouble();
    final double rainChance = (values['precipitationProbability'] ?? 0).toDouble();
    final double uvIndex = (values['uvIndex'] ?? 0).toDouble();
    final double soilMoisture = (values['soilMoistureVolumetric0To10'] ?? 0).toDouble();

    return WeatherModel(
      temperature: temp,
      windSpeed: windSpeed,
      rainChance: rainChance,
      uvIndex: uvIndex,
      soilMoisture: soilMoisture,
      condition: WeatherEnumEx.detect(
        temp: temp,
         soilMoisture: soilMoisture,
        windSpeed: windSpeed,
        rainChance: rainChance,
        uvIndex: uvIndex,
      ),
    );
  }
}