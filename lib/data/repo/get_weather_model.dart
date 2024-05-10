import 'package:wheather_app/data/api/wheather_api.dart';
import 'package:wheather_app/data/model/wheather_model.dart';

class GetWeatherModel {
  static double? lat;
  static double? long;
  static WeatherModel? weatherModel;
  fetchWheather() async {
    // get the current city

    String? position =
        await WeatherApiService().getCurrentLocation().then((value) {
      lat = value.latitude;
      long = value.longitude;
    });

    // get weather for weather Models
    try {
      final weather = await WeatherApiService().getWheatherData(lat!, long);

      weatherModel = weather;
    } catch (e) {
      print(e.toString());
    }
  }
}
