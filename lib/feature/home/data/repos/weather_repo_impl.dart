

import 'package:agri_guide_app/feature/home/data/models/weather_model.dart';
import 'package:agri_guide_app/feature/home/domain/entityes/weather_entity.dart';
import 'package:agri_guide_app/feature/home/domain/repos/weather_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherRepoImpl extends WeatherRepo{
  final dio = Dio();
  final weatherApikey=dotenv.env['WEATHER_APIKEY'];
  @override
  Future<WeatherEntity> getWeather({required double longitude,required double latitude})async {
    final String url="https://api.tomorrow.io/v4/weather/forecast?location=$latitude,$longitude&apikey=$weatherApikey";
   final response= await dio.get(url);
   final data=response.data;
  
   return WeatherModel.fromJson(data);
  }
}