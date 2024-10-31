part of 'daily_weather_bloc.dart';

sealed class DailyWeatherState extends Equatable {
  const DailyWeatherState();
}

class LoadingDailyWeatherState extends DailyWeatherState {
  const LoadingDailyWeatherState();

  @override
  List<Object?> get props => [];
}

class ErrorDailyWeatherState extends DailyWeatherState {
  const ErrorDailyWeatherState({this.message = 'An error occurred'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SuccessDailyWeatherState extends DailyWeatherState {
  const SuccessDailyWeatherState(this._weather);

  final DailyWeather _weather;

  DailyWeather get weather => _weather;

  String get cityName => _weather.name ?? '';

  String get weatherCondition => _weather.weather?.first.main ?? '';

  String get date {
    final date = _weather.dt;
    return DateTime.fromMillisecondsSinceEpoch((date ?? 0) * 1000).dayOfWeekOrRelative;
  }

  String get temperature {
    final temp = _weather.main?.temp;
    return temp == null ? '' : '${temp.round()}°';
  }

  String get icon {
    final icon = _weather.weather?.first.icon;
    return icon == null ? '' : 'http://openweathermap.org/img/wn/$icon@2x.png';
  }

  String get windSpeed {
    final speed = _weather.wind?.speed;
    return speed == null ? '' : '${speed.round()} m/s';
  }

  String get humidity {
    final humidity = _weather.main?.humidity;
    return humidity == null ? '' : '$humidity%';
  }

  String get pressure {
    final pressure = _weather.main?.pressure;
    return pressure == null ? '' : '$pressure hPa';
  }

  @override
  List<Object?> get props => [_weather];
}
