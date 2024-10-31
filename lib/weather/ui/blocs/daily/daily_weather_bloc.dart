import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaconi_weather/shared/utils/date_utils.dart';
import 'package:flaconi_weather/weather/data/models/daily_weather.dart';
import 'package:flaconi_weather/weather/data/repository/weather_repository.dart';

part 'daily_weather_event.dart';
part 'daily_weather_state.dart';

class DailyWeatherBloc extends Bloc<DailyWeatherEvent, DailyWeatherState> {
  final WeatherRepository _repository = WeatherRepository();
  final String units;
  DailyWeatherBloc({this.units = "metric"}) : super(const LoadingDailyWeatherState()) {
    on<GetDailyWeatherByLocation>(_getDailyWeatherByLocation);
    on<GetDailyWeatherByCity>(_getDailyWeatherByCity);
  }

  Future<void> _getDailyWeatherByLocation(
    GetDailyWeatherByLocation event,
    Emitter<DailyWeatherState> emit,
  ) async {
    try {
      emit(const LoadingDailyWeatherState());
      final response = await _repository.getWeatherByLocation(units: units);
      response.fold(
        (l) => emit(ErrorDailyWeatherState(message: l.error)),
        (r) => emit(SuccessDailyWeatherState(r)),
      );
    } catch (e) {
      emit(ErrorDailyWeatherState(message: e.toString()));
    }
  }

  Future<void> _getDailyWeatherByCity(
    GetDailyWeatherByCity event,
    Emitter<DailyWeatherState> emit,
  ) async {
    try {
      emit(const LoadingDailyWeatherState());
      final response = await _repository.getWeatherByCity(event.cityName, units: units);
      response.fold(
        (l) => emit(ErrorDailyWeatherState(message: l.error)),
        (r) => emit(SuccessDailyWeatherState(r)),
      );
    } catch (e) {
      emit(ErrorDailyWeatherState(message: e.toString()));
    }
  }
}
