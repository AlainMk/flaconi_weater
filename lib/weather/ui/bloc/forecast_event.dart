part of 'forecast_bloc.dart';

sealed class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class GetForecastByLocation extends ForecastEvent {
  const GetForecastByLocation({this.units = WeatherUnit.metric});

  final WeatherUnit units;

  @override
  List<Object?> get props => [units];
}

class GetForecastByCity extends ForecastEvent {
  const GetForecastByCity(this.cityName, {this.units = WeatherUnit.metric});

  final String cityName;
  final WeatherUnit units;

  @override
  List<Object?> get props => [cityName, units];
}

class SelectForecastItem extends ForecastEvent {
  final DailyAverage forecast;

  const SelectForecastItem(this.forecast);

  @override
  List<Object?> get props => [forecast];
}

class ChangeUnits extends ForecastEvent {
  const ChangeUnits(this.units);

  final WeatherUnit units;

  @override
  List<Object?> get props => [units];
}
