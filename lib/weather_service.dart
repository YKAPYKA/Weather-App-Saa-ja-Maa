import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "d54f050abbb2618a1f832335599a3ab4"; // tähän lisätty API avain

  Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}