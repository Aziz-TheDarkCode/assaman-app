import 'dart:convert';

import 'package:assaman/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  static final Map<String, Map<String, double>> cities = {
    'Dakar': {'latitude': 14.7167, 'longitude': -17.4677},
    // 'Paris': {'latitude': 48.8566, 'longitude': 2.3522},
    'New York': {'latitude': 40.7128, 'longitude': -74.0060},
    'Tokyo': {'latitude': 35.6762, 'longitude': 139.6503},
    // 'Dubai': {'latitude': 25.2048, 'longitude': 55.2708},
    // 'Sydney': {'latitude': -33.8688, 'longitude': 151.2093},
    'Abidjan': {'latitude': 5.3600, 'longitude': -4.0083},
    'Casablanca': {'latitude': 33.5731, 'longitude': -7.5898},
    'Lagos': {'latitude': 6.5244, 'longitude': 3.3792},
    'Le Caire': {'latitude': 30.0444, 'longitude': 31.2357},
    'Johannesburg': {'latitude': -26.2041, 'longitude': 28.0473},
    'Nairobi': {'latitude': -1.2921, 'longitude': 36.8219},
    'Accra': {'latitude': 5.6037, 'longitude': -0.1870},
    'Bamako': {'latitude': 12.6392, 'longitude': -8.0029},
    'Ouagadougou': {'latitude': 12.3714, 'longitude': -1.5197},
  };

  static Future<List<WeatherData>> getWeatherForCities() async {
    List<WeatherData> weatherDataList = [];
    
    for (var entry in cities.entries) {
      try {
        final weatherData = await _fetchWeatherData(
          entry.key,
          entry.value['latitude']!,
          entry.value['longitude']!,
        );
        weatherDataList.add(weatherData);
      } catch (e) {
        print('Error fetching weather for ${entry.key}: $e');
        // Continue with next city if one fails
        continue;
      }
    }

    return weatherDataList;
  }

  static Future<WeatherData> _fetchWeatherData(
    String cityName,
    double latitude,
    double longitude,
  ) async {
    final Uri uri = Uri.parse(
      '$baseUrl?latitude=$latitude&longitude=$longitude'
      '&current=temperature_2m,windspeed_10m,weather_code,precipitation'
      '&timezone=auto'
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final current = data['current'];

        return WeatherData(
          city: cityName,
          temperature: current['temperature_2m']?.toDouble() ?? 0.0,
          windspeed: current['windspeed_10m']?.toDouble() ?? 0.0,
          weatherCode: current['weather_code'] ?? 0,
          precipitation: current['precipitation']?.toDouble() ?? 0.0,
          latitude: latitude,
          longitude: longitude,
        );
      } else {
        throw Exception('Failed to load weather data for $cityName');
      }
    } catch (e) {
      throw Exception('Network error for $cityName: $e');
    }
  }
}
