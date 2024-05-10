class WeatherSwetch {
  String getWeatherAnimation(String? main_condiation) {
    if (main_condiation == null) return 'assts/animation/clear.json';
    switch (main_condiation.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/animation/cloud.json";
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animation/rain.json';
      case 'thunderstorm':
        return 'thunder';
      case 'clear':
        return 'assets/animation/clear.json';
      default:
        return 'assets/animation/clear.json';
    }
  }
}
