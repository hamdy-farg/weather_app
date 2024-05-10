import "dart:convert";

import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:http/http.dart" as http;
import "package:wheather_app/constats/constants.dart";
import "package:wheather_app/data/model/wheather_model.dart";

class WeatherApiService {
  getWheatherData(double lat, long) async {
    // parse URL from string to link
    var URL =
        Uri.parse('$base_url?lat=$lat&lon=$long&appid=$api_key&units=metric');
    try {

      // get the data from api
      http.Response response = await http.get(URL);
      // check if the service is done or not
      if (response.statusCode == 200) {
      // decode the json file to use it in our code 
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("field to load current wheather data ");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
    return await Geolocator.getCurrentPosition();
  }
}
