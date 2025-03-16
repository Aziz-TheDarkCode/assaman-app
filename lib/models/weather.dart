import 'package:flutter/material.dart';

class WeatherData {
  final String city;
  final double temperature;
  final double windspeed;
  final int weatherCode;
  final double precipitation;
  final double latitude;
  final double longitude;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.windspeed,
    required this.weatherCode,
    required this.precipitation,
    required this.latitude,
    required this.longitude,
  });

  // Helper method to get weather condition description based on WMO code
  String get weatherCondition {
    // Simplified mapping of WMO weather codes
    if (weatherCode < 10) return 'Clear';
    if (weatherCode < 20) return 'Partly cloudy';
    if (weatherCode < 30) return 'Cloudy';
    if (weatherCode < 40) return 'Fog';
    if (weatherCode < 50) return 'Drizzle';
    if (weatherCode < 60) return 'Rain';
    if (weatherCode < 70) return 'Snow';
    if (weatherCode < 80) return 'Shower';
    if (weatherCode < 100) return 'Thunderstorm';
    return 'Unknown';
  }

  // Helper method to get weather icon based on WMO code
  IconData get weatherIcon {
    if (weatherCode < 10) return Icons.wb_sunny;
    if (weatherCode < 20) return Icons.cloudy_snowing;
    if (weatherCode < 30) return Icons.cloud;
    if (weatherCode < 40) return Icons.foggy;
    if (weatherCode < 70) return Icons.grain;
    if (weatherCode < 80) return Icons.ac_unit;
    if (weatherCode < 100) return Icons.flash_on;
    return Icons.help_outline;
  }
}
