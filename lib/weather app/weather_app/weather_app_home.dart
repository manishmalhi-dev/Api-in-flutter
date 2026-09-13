import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_apis/weather%20app/weather_model_class.dart';
import 'package:http/http.dart' as http;

class WeatherAppHome extends StatefulWidget {
  const WeatherAppHome({super.key});

  @override
  State<WeatherAppHome> createState() => _WeatherAppHomeState();
}

class _WeatherAppHomeState extends State<WeatherAppHome> {
  TextEditingController location = TextEditingController();
  
  WeatherModelClass? getWeather;

  bool isLoading = true;
  bool dataGet = false;

  Future<void> getWeatherData() async {
    if (location.text.isNotEmpty) {
      setState(() {
        isLoading = true;
        dataGet = true;
      });
      try {
        String locationIs = location.text.trim();
        final link = "http://api.weatherapi.com/v1/current.json?key=4baffbf2048542a795472906261109&q=$locationIs&aqi=no";
        final response = await http.get(Uri.parse(link));
        if (response.statusCode == 200) {

          final finalResponse = jsonDecode(response.body);
          getWeather = WeatherModelClass.fromJson(finalResponse);
          setState(() {
            isLoading = false;
            dataGet = true;
          });

        } else {
          print("Api can't run properly");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: location,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            location.clear();
                            setState(() {
                              isLoading = true;
                              dataGet = false;
                            });
                          },
                          icon: Icon(Icons.close),
                        ),
                        hintText: "Enter Your City",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(100, 50),
                    ),
                    onPressed: () {
                      getWeatherData();
                    },
                    child: Text("get data"),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Card(
                child: isLoading == true
                    ? Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          width: double.infinity,
                          child: Center(
                            child:
                            dataGet == true
                                ?CircularProgressIndicator()
                                :Text("Enter Location to get Weather")
                          ),
                        ),
                      )
                    : Column(
                        spacing: 20,
                        children: [
                          Icon(
                            Icons.cloud_done_rounded,
                            size: 100,
                            color: Colors.blueAccent,
                          ),
                          Row(
                            spacing: 10,
                            children: [
                              changeFontSize("Get Location"),
                              Expanded(
                                child: Text(getWeather!.locationName,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              changeFontSize("Temperature"),
                              changeFontSize(getWeather!.locationRegion),
                            ],
                          ),
                          Row(
                            children: [
                              changeFontSize("Humidity"),
                              changeFontSize(getWeather!.locationCountry),
                            ],
                          ),
                          Row(
                            children: [
                              changeFontSize("temperature"),
                              changeFontSize("${getWeather!.temperature}"),
                            ],
                          ),
                          Row(
                            children: [
                              changeFontSize("humidity"),
                              changeFontSize("${getWeather!.humidity}"),
                            ],
                          ),
                          Row(
                            children: [
                              changeFontSize("wind_kph"),
                              changeFontSize("${getWeather!.wind}"),
                            ],
                          ),


                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget changeFontSize(String data) {
  return Text("$data : ", style: TextStyle(fontSize: 20));
}
