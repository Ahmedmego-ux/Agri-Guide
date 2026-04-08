

import 'package:agri_guide_app/feature/home/data/models/weather_model.dart';
import 'package:agri_guide_app/feature/home/domain/entityes/weather_entity.dart';
import 'package:agri_guide_app/feature/home/domain/repos/weather_repo.dart';
import 'package:dio/dio.dart';

class WeatherRepoImpl extends WeatherRepo{
  final dio = Dio();
  @override
  Future<WeatherEntity> getWeather({required double longitude,required double latitude})async {
    final String url="https://api.tomorrow.io/v4/weather/forecast?location=$latitude,$longitude&apikey=wkxsP72io5LCsbDZbOHrQKtj3pWiNth5";
   final response= await dio.get(url);
   final data=response.data;
  
   return WeatherModel.fromJson(data);
  }
}