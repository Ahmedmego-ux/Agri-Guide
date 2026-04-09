import 'package:agri_guide_app/core/erorr/error_handler.dart';

import 'package:agri_guide_app/feature/home/domain/entityes/weather_entity.dart';

import 'package:agri_guide_app/feature/home/domain/repos/weather_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo repo;
  WeatherCubit(this.repo) : super(WeatherInitial());
  Future<void>getWeather( double? latitude,double? longitude)async{
    if (latitude == null || longitude == null) {
      emit(WeatherFaliure(errmessage: 'Latitude and longitude are required'));
      return;
    }
    emit(WeatherLoading());
try {
  final weather= await repo.getWeather(longitude: longitude, latitude:latitude);
  emit(WeatherSuccess(weather: weather));
} catch (e) {
  emit(WeatherFaliure(errmessage: ErrorHandler.handlePostgrestError(e.toString())));
}
  }
}
