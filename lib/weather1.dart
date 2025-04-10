import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App (Dummy Data)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _weather = "Enter a city to get the weather";
  bool _isLoading = false;

  Future<void> fetchWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _weather = "Fetching weather...";
    });

    // Simulate a delay like an API request
    await Future.delayed(const Duration(seconds: 2));

    // Dummy AI-like weather data map
    final dummyWeatherData = {
      "chennai": {"temp": 32, "desc": "Sunny"},
      "mumbai": {"temp": 30, "desc": "Partly Cloudy"},
      "delhi": {"temp": 28, "desc": "Hazy"},
      "bengaluru": {"temp": 25, "desc": "Cloudy"},
      "default": {"temp": 27, "desc": "Clear Sky"}
    };

    final cityLower = city.toLowerCase();
    final weatherInfo = dummyWeatherData[cityLower] ?? dummyWeatherData["default"];

    setState(() {
      _weather = "${weatherInfo["temp"]}°C | ${weatherInfo["desc"].toString().toUpperCase()}";
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App (Dummy)'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud, size: 80, color: Colors.blueGrey),
              const SizedBox(height: 20),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => fetchWeather(_cityController.text),
                child: const Text('Get Weather'),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      _weather,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
