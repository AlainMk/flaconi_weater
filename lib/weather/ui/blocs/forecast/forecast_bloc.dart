import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaconi_weather/shared/utils/date_utils.dart';
import 'package:flaconi_weather/weather/data/models/daily_average.dart';
import 'package:flaconi_weather/weather/data/repository/weather_repository.dart';
import 'package:get_it/get_it.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(const LoadingForecastState()) {
    on<GetForecastByCity>(_getForecastByCity);
    on<ChangeUnits>(_changeUnits);
  }

  Future<void> _getForecastByCity(
    GetForecastByCity event,
    Emitter<ForecastState> emit,
  ) async {
    try {
      emit(const LoadingForecastState());
      final response = await _repository.getSevenDayForecastByCity(event.cityName);
      response.fold(
        (l) => emit(ErrorForecastState(message: l.error)),
        (r) => emit(SuccessForecastState(r)),
      );
    } catch (e) {
      emit(ErrorForecastState(message: e.toString()));
    }
  }

  Future<void> _changeUnits(
    ChangeUnits event,
    Emitter<ForecastState> emit,
  ) async {
    try {
      emit(const LoadingForecastState());
      final response = await _repository.getSevenDayForecastByCity(event.cityName, units: event.units);
      response.fold(
        (l) => emit(ErrorForecastState(message: l.error)),
        (r) => emit(SuccessForecastState(r)),
      );
    } catch (e) {
      emit(ErrorForecastState(message: e.toString()));
    }
  }

  final WeatherRepository _repository = GetIt.instance<WeatherRepository>();
}
