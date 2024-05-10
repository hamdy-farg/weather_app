import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wheather_app/data/model/wheather_model.dart';
import 'package:wheather_app/data/repo/get_weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        await GetWeatherModel().fetchWheather();
        emit(WeatherLoaded(weatherModel: GetWeatherModel.weatherModel!));
      } catch (e) {
        emit(WeatherError(msg: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
