part of 'forecast_bloc.dart';

sealed class ForecastState extends Equatable {
  const ForecastState();
}

class LoadingForecastState extends ForecastState {
  const LoadingForecastState();

  @override
  List<Object?> get props => [];
}

class ErrorForecastState extends ForecastState {
  const ErrorForecastState({this.message = 'An error occurred'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SuccessForecastState extends ForecastState {
  const SuccessForecastState(this._forecast);

  final List<DailyAverage> _forecast;

  List<ForecastItem> get forecastItems {
    return _forecast.map((e) => ForecastItem(e)).toList();
  }

  @override
  List<Object?> get props => [_forecast];
}

class ForecastItem {
  final DailyAverage _dailyForecast;

  ForecastItem(this._dailyForecast);

  String get date {
    final date = _dailyForecast.date.shortDayOfWeek;
    return date;
  }

  String get icon {
    final icon = _dailyForecast.icon;
    return 'http://openweathermap.org/img/wn/$icon@2x.png';
  }

  String get temperature {
    final min = _dailyForecast.minTemperature;
    final max = _dailyForecast.maxTemperature;
    return '${min.round()}° / ${max.round()}°';
  }
}
