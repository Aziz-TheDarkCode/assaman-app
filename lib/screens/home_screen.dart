import 'package:assaman/models/weather.dart';
import 'package:assaman/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:assaman/screens/city_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:assaman/providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        _errorMessage = 'Erreur lors du chargement des données météo';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchWeatherData,
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode 
                      ? Icons.light_mode 
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
              );
            },
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchWeatherData,
              child: Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _weatherData.length,
      itemBuilder: (context, index) {
        final weather = _weatherData[index];
        return Hero(
          tag: 'weather_${weather.city}',
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                weather.weatherIcon,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(weather.city),
              subtitle: Text(weather.weatherCondition),
              trailing: Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityDetailScreen(weatherData: weather),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
