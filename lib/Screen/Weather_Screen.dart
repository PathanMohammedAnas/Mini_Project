import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherDetailsPage extends StatefulWidget {
  final String cityName;
  final double latitude;
  final double longitude;

  WeatherDetailsPage({
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });

  @override
  _WeatherDetailsPageState createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  Map<String, dynamic>? weatherData;
  final String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  @override
  void initState() {
    super.initState();
    fetchWeatherDetails();
  }

  Future<void> fetchWeatherDetails() async {
    final String url =
        '$baseUrl?latitude=${widget.latitude}&longitude=${widget.longitude}&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=auto';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherData = data;
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  IconData getWeatherIcon(int weatherCode) {
    switch (weatherCode) {
      case 0: // Clear sky
      case 1: // Mainly clear
      case 2: // Partly cloudy
        return Icons.wb_sunny;
      case 3: // Overcast
        return Icons.cloud;
      case 45: // Fog
      case 48: // Depositing rime fog
        return Icons.foggy;
      case 51: // Light drizzle
      case 53: // Moderate drizzle
      case 55: // Dense drizzle
        return Icons.grain;
      case 61: // Slight rain
      case 63: // Moderate rain
      case 65: // Heavy rain
        return Icons.umbrella;
      case 71: // Slight snow
      case 73: // Moderate snow
      case 75: // Heavy snow
        return Icons.ac_unit;
      case 95: // Thunderstorm
      case 99: // Thunderstorm with hail
        return Icons.flash_on;
      default:
        return Icons.help; // Default icon for unknown weather codes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cityName} Weather', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        elevation: 8,
      ),
      body: weatherData != null
          ? Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "7-Day Weather Forecast",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: weatherData!['daily']['time'].length,
                  itemBuilder: (context, index) {
                    final weatherCode = weatherData!['daily']['weathercode'][index];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.blue.shade50],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date: ${weatherData!['daily']['time'][index]}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          getWeatherIcon(weatherCode),
                                          size: 32,
                                          color: Colors.orangeAccent,
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          getWeatherCondition(weatherCode),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Max: ${weatherData!['daily']['temperature_2m_max'][index]}°C',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade500,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          'Min: ${weatherData!['daily']['temperature_2m_min'][index]}°C',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.cloud_queue,
                                size: 50,
                                color: Colors.blueGrey.shade300,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  String getWeatherCondition(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Mainly clear';
      case 2:
        return 'Partly cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Fog';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 95:
        return 'Thunderstorm';
      case 99:
        return 'Thunderstorm with hail';
      default:
        return 'Unknown weather condition';
    }
  }
}
