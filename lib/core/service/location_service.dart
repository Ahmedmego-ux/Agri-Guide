import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';


class LocationService {
  // التحقق من صلاحية الموقع
  static Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // طلب صلاحية الموقع
  static Future<bool> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      // فتح إعدادات التطبيق إذا كان ممنوع نهائياً
      await openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  // الحصول على الموقع الحالي
  static Future<Position?> getCurrentLocation() async {
    try {
      // التحقق من الخدمة
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      // التحقق من الصلاحية
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      // الحصول على الموقع
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      return position;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

 

Future<Map<String, double>?> getCoordinatesFromCity(String cityName) async {
  try {
    List<Location> locations = await locationFromAddress(cityName);
    if (locations.isNotEmpty) {
      return {
        'lat': locations.first.latitude,
        'lon': locations.first.longitude,
      };
    }
  } catch (e) {
    print('Error getting coordinates: $e');
  }
  return null;
}
}