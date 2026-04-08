// weather_entity.dart
import 'package:agri_guide_app/feature/home/presentation/enums/weather_enum.dart';

class WeatherEntity {
  final double temperature;
  final double windSpeed;
  final double rainChance;
  final double uvIndex;
  final double soilMoisture;
  final WeatherEnum condition;

  WeatherEntity({
    required this.temperature,
    required this.windSpeed,
    required this.rainChance,
    required this.uvIndex,
    required this.soilMoisture,
    required this.condition,
  });
}