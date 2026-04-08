part of 'weather_cubit.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}
final class WeatherLoading extends WeatherState {}
final class WeatherSuccess extends WeatherState {
  final WeatherEntity weather;

  WeatherSuccess({required this.weather});
}
final class WeatherFaliure extends WeatherState {
  final String errmessage;

  WeatherFaliure({required this.errmessage});
}
