import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Weather App Sää & Mää"),
          ],
        ),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          String backgroundImage = "assets/mainmain.jpg"; // Aloitusvalikon taustakuva

          if (provider.weatherData != null) {
            String condition = provider.weatherData!["weather"][0]["main"];

            if (condition == "Clear") {
              backgroundImage = "assets/sunny.jpg";
            } else if (condition == "Clouds") {
              backgroundImage = "assets/cloudy.jpg";
            } else if (condition == "Rain") {
              backgroundImage = "assets/rainy.jpg";
            } else if (condition == "Snow") {
              backgroundImage = "assets/snowy.jpg";
            } // Näillä vaihdetaan taustakuva sään mukaiseen kuvaan
          }

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Enter City",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<WeatherProvider>(context, listen: false)
                          .getWeather(_controller.text);
                    },
                    child: Text("Get Weather"),
                  ),
                  SizedBox(height: 30),
                  Consumer<WeatherProvider>(
                    builder: (context, provider, child) {
                      if (provider.weatherData == null) {
                        return Text("");
                      }
                      String condition = provider.weatherData!["weather"][0]["main"];
                      int temperature = provider.weatherData!["main"]["temp"].toInt(); // Pyöristetään lämpötila ilman desimaaleja

                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Temperature : $temperature°C",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Condition : $condition",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      );
                    },
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
