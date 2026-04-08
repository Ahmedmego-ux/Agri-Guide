import 'package:agri_guide_app/feature/home/domain/entityes/weather_entity.dart';

abstract class WeatherRepo {
  Future<WeatherEntity>getWeather({required double longitude,required double latitude});
}