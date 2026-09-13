class WeatherModelClass {
  String locationName;
  String locationRegion;
  String locationCountry;
  double temperature;
  int humidity;
  double wind;

  WeatherModelClass({
    required this.locationName,
    required this.locationRegion,
    required this.locationCountry,
    required this.temperature,
    required this.humidity,
    required this.wind,
  });

  factory WeatherModelClass.fromJson(Map<String, dynamic> json) {
    return WeatherModelClass(
      locationName: json["location"]['name'],
      locationRegion: json["location"]['region'],
      locationCountry: json["location"]['country'],
      temperature: json["current"]['temp_c'] as double,
      humidity: json["current"]['humidity'],
      wind: json["current"]['wind_kph'] as double,
    );
  }
}

