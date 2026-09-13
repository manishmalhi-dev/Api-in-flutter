class WeatherModel {
  String location;
  double temperature;
  int humidity;

  WeatherModel({
    required this.location,
    required this.temperature,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json["location"],
      temperature: json["temperature"],
      humidity: json["humidity"],
    );
  }
}
