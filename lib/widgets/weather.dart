import 'package:assaman/models/weather.dart';
import 'package:assaman/services/weather.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  List<WeatherData> _weatherData = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weatherData = await WeatherService.getWeatherForCities();
      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch weather data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in Major Cities'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchWeatherData,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage, textAlign: TextAlign.center),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchWeatherData,
                child: Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchWeatherData,
      child: ListView.builder(
        itemCount: _weatherData.length,
        itemBuilder: (context, index) {
          final weather = _weatherData[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weather.city,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        weather.weatherIcon,
                        size: 32,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°C | ${weather.weatherCondition}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.air, size: 16),
                      SizedBox(width: 4),
                      Text(
                          'Wind: ${weather.windspeed.toStringAsFixed(1)} km/h'),
                      SizedBox(width: 16),
                      Icon(Icons.water_drop, size: 16),
                      SizedBox(width: 4),
                      Text(
                          'Precip: ${weather.precipitation.toStringAsFixed(1)} mm'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
