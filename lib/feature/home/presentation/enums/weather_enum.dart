// lib/feature/weather/domain/entity/weather_condition.dart

import 'package:flutter/material.dart';

enum WeatherEnum {
  sunny,
  partlyCloudy,
  cloudy,
  rainy,
  windy,
  highHumidity,
  highUV,
  cold,
}

extension WeatherEnumEx on WeatherEnum {
  IconData get icon {
    switch (this) {
      case WeatherEnum.sunny:
        return Icons.wb_sunny;
      case WeatherEnum.partlyCloudy:
        return Icons.wb_cloudy;
      case WeatherEnum.cloudy:
        return Icons.cloud;
      case WeatherEnum.rainy:
        return Icons.water_drop;
      case WeatherEnum.windy:
        return Icons.air;
      case WeatherEnum.highHumidity:
        return Icons.water;
      case WeatherEnum.highUV:
        return Icons.brightness_high;
      case WeatherEnum.cold:
        return Icons.ac_unit;
    }
  }

  LinearGradient get backgroundGradient {
  switch (this) {
    case WeatherEnum.sunny:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFA726), // برتقالي فاتح
          Color(0xFFFF7043), // برتقالي غامق
        ],
      );

    case WeatherEnum.rainy:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1E88E5),
          Color(0xFF1565C0),
        ],
      );

    case WeatherEnum.cloudy:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF90A4AE),
          Color(0xFF546E7A),
        ],
      );

    case WeatherEnum.partlyCloudy:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF64B5F6),
          Color(0xFFFFCA28), // لمسة شمس خفيفة
        ],
      );

    case WeatherEnum.windy:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4DD0E1),
          Color(0xFF0097A7),
        ],
      );

    case WeatherEnum.highHumidity:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4FC3F7),
          Color(0xFF0288D1),
        ],
      );

    case WeatherEnum.highUV:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFF7043),
          Color(0xFFD84315),
        ],
      );

    case WeatherEnum.cold:
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF64B5F6),
          Color(0xFF1A237E),
        ],
      );
  }
}



  Color get iconColor {
    switch (this) {
      case WeatherEnum.sunny:
         return Colors.orangeAccent;
      case WeatherEnum.partlyCloudy:
        return Colors.blueGrey;
      case WeatherEnum.cloudy:
        return Colors.grey;
      case WeatherEnum.rainy:
        return Colors.blue;
      case WeatherEnum.windy:
        return Colors.cyan;
      case WeatherEnum.highHumidity:
        return Colors.lightBlue;
      case WeatherEnum.highUV:
        return Colors.orange;
      case WeatherEnum.cold:
        return Colors.lightBlue;
    }
  }


  String get tip {
    switch (this) {
      case WeatherEnum.sunny:
        return 'Water your plants early morning';
      case WeatherEnum.partlyCloudy:
        return 'Great day for outdoor farming';
      case WeatherEnum.cloudy:
        return 'Good day for transplanting seedlings';
      case WeatherEnum.rainy:
        return 'No need to irrigate today';
      case WeatherEnum.windy:
        return 'Avoid spraying pesticides today';
      case WeatherEnum.highHumidity:
        return 'Watch out for fungal diseases';
      case WeatherEnum.highUV:
        return 'Protect sensitive crops from direct sun';
      case WeatherEnum.cold:
        return 'Cover sensitive plants tonight';
    }
  }

  static WeatherEnum detect({
    required double temp,
    required double soilMoisture,
    required double windSpeed,
    required double rainChance,
    required double uvIndex,
  }) {
     if (rainChance > 50) return WeatherEnum.rainy;

  if (windSpeed > 30) return WeatherEnum.windy;

  if (uvIndex > 7) return WeatherEnum.highUV;

  if (temp < 10) return WeatherEnum.cold;

  if (soilMoisture > 0.6) return WeatherEnum.highHumidity;

  if (temp > 25) return WeatherEnum.sunny;

  if (temp >= 15 && temp <= 25) return WeatherEnum.partlyCloudy;

  return WeatherEnum.cloudy;
  }
}