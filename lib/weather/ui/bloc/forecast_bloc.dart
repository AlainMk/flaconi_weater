import 'package:equatable/equatable.dart';
import 'package:flaconi_weather/shared/utils/date_utils.dart';
import 'package:flaconi_weather/weather/data/models/daily_average.dart';
import 'package:flaconi_weather/weather/data/repository/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(const LoadingForecastState()) {
    on<GetForecastByCity>(_getForecastByCity);
    on<GetForecastByLocation>(_getForecastByLocation);
    on<ChangeUnits>(_changeUnits);
    on<SelectForecastItem>(_selectForecast);
  }

  Future<void> _getForecastByLocation(
    GetForecastByLocation event,
    Emitter<ForecastState> emit,
  ) async {
    try {
      emit(const LoadingForecastState());
      final response = await _repository.getSixDayForecastByLocation();
      response.fold(
        (l) => emit(ErrorForecastState(message: l.error)),
        (r) => emit(SuccessForecastState(r, r.first)),
      );
    } catch (e) {
      emit(ErrorForecastState(message: e.toString()));
    }
  }

  Future<void> _getForecastByCity(
    GetForecastByCity event,
    Emitter<ForecastState> emit,
  ) async {
    try {
      emit(const LoadingForecastState());
      final response = await _repository.getSixDayForecastByCity(event.cityName);
      response.fold(
        (l) => emit(ErrorForecastState(message: l.error)),
        (r) => emit(SuccessForecastState(r, r.first, cityName: event.cityName)),
      );
    } catch (e) {
      emit(ErrorForecastState(message: e.toString()));
    }
  }

  void _selectForecast(
    SelectForecastItem event,
    Emitter<ForecastState> emit,
  ) {
    emit((state as SuccessForecastState).copyWith(selectedForecast: event.forecast));
  }

  Future<void> _changeUnits(
    ChangeUnits event,
    Emitter<ForecastState> emit,
  ) async {
    try {
      emit(const LoadingForecastState());
      final response = await _repository.getSixDayForecastByCity(event.cityName, units: event.units);
      response.fold(
        (l) => emit(ErrorForecastState(message: l.error)),
        (r) => emit(SuccessForecastState(r, r.first, cityName: event.cityName)),
      );
    } catch (e) {
      emit(ErrorForecastState(message: e.toString()));
    }
  }

  final WeatherRepository _repository = GetIt.instance<WeatherRepository>();
}
