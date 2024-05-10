import 'package:wheather_app/data/api/wheather_api.dart';

class WeatherModel {
   String city_name;
  final double temp;
  final String mainConditoin;

  WeatherModel(
      {required this.city_name,
      required this.temp,
      required this.mainConditoin});

// to conver from json api to our model
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        city_name: json["name"],
        temp: json["main"]["temp"],
        mainConditoin: json["weather"][0]["main"]);
  }
}
