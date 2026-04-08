import 'dart:convert';
import 'package:agri_guide_app/core/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationHandler {
  final Function(String, Color) showSnack;
  final Function(double, double, String) onLocationObtained; // ✅ أضفنا cityName

  LocationHandler({
    required this.showSnack,
    required this.onLocationObtained,
  });

  bool _isGettingLocation = false;

  Future<void> getLocation() async {
    _isGettingLocation = true;

    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        showSnack('Please enable GPS', Colors.red);
        return;
      }

      if (!await LocationService.requestLocationPermission()) {
        showSnack('Location permission is required', Colors.red);
        return;
      }

      final position = await LocationService.getCurrentLocation();

      if (position != null) {
        final cityName = await _getCityFromCoordinates(
          position.latitude,
          position.longitude,
        );

        // ✅ نمرر latitude, longitude, و cityName
        onLocationObtained(position.latitude, position.longitude, cityName);
       // showSnack('Location detected: $cityName', Colors.green);
      } else {
        showSnack('Could not get location', Colors.red);
      }
    } catch (e) {
      showSnack('Error: $e', Colors.red);
    } finally {
      _isGettingLocation = false;
    }
  }

  Future<String> _getCityFromCoordinates(double lat, double lng) async {
    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng');

      final response = await http.get(url, headers: {
        'User-Agent': 'AgriGuideApp/1.0',
      });

if (response.statusCode == 200) {
  final data = json.decode(response.body);

  final city = data['address']['city'] ??
      data['address']['town'] ??
      data['address']['village'] ??
      data['address']['suburb'];

  final governorate = data['address']['state'];
  final country = data['address']['country'];

  // ✅ "منوف، المنوفية، مصر"
  if (city != null && governorate != null && country != null) {
    return '$city، $governorate، $country';
  }
  if (city != null && governorate != null) return '$city، $governorate';
  if (city != null) return city;
  if (governorate != null) return governorate;
  if (country != null) return country;
}
    } catch (e) {
      print('Error getting city name: $e');
    }
    // لو فشل، نرجع الإحداثيات
    return '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}';
  }

  bool get isLoading => _isGettingLocation;
}