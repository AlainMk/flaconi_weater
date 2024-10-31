part of 'daily_weather_bloc.dart';

sealed class DailyWeatherEvent extends Equatable {
  const DailyWeatherEvent();
}

class GetDailyWeatherByLocation extends DailyWeatherEvent {
  const GetDailyWeatherByLocation();

  @override
  List<Object?> get props => [];
}

class GetDailyWeatherByCity extends DailyWeatherEvent {
  const GetDailyWeatherByCity(this.cityName);

  final String cityName;

  @override
  List<Object?> get props => [cityName];
}

class ChangeUnits extends DailyWeatherEvent {
  const ChangeUnits(this.units);

  final String units;

  @override
  List<Object?> get props => [units];
}
