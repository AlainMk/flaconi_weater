part of 'forecast_bloc.dart';

sealed class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class GetForecastByLocation extends ForecastEvent {
  const GetForecastByLocation();

  @override
  List<Object?> get props => [];
}

class GetForecastByCity extends ForecastEvent {
  const GetForecastByCity(this.cityName);

  final String cityName;

  @override
  List<Object?> get props => [cityName];
}

class ChangeUnits extends ForecastEvent {
  const ChangeUnits(this.units, this.cityName);

  final String units;
  final String cityName;

  @override
  List<Object?> get props => [units, cityName];
}
