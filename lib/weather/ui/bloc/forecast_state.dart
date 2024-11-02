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
  const SuccessForecastState(this._forecast, this._selectedForecast, {this.cityName, this.units = WeatherUnit.metric});

  final List<DailyAverage> _forecast;
  final DailyAverage _selectedForecast;
  final String? cityName;
  final WeatherUnit units;

  List<ForecastItem> get forecastItems {
    return _forecast.map((e) => ForecastItem(e)).toList();
  }

  SelectedForecastDetails get selectedForecastDetails => SelectedForecastDetails(_selectedForecast);

  @override
  List<Object?> get props => [_forecast, _selectedForecast, cityName, units];

  SuccessForecastState copyWith({
    List<DailyAverage>? forecast,
    DailyAverage? selectedForecast,
    String? cityName,
    WeatherUnit? units,
  }) {
    return SuccessForecastState(
      forecast ?? _forecast,
      selectedForecast ?? _selectedForecast,
      cityName: cityName ?? this.cityName,
      units: units ?? this.units,
    );
  }
}

class SelectedForecastDetails {
  const SelectedForecastDetails(this._forecast);

  final DailyAverage _forecast;

  DailyAverage get item => _forecast;

  bool get isToday => _forecast.date.isAtSameMomentAs(DateTime.now());

  String get weatherCondition => isToday ? _forecast.weatherCondition : _forecast.commonWeatherCondition;

  DateTime get date => _forecast.date;

  String get convertedDate => _forecast.date.dayOfWeekOrRelative;

  String get temperature {
    final temperature = isToday ? _forecast.temperature : _forecast.averageTemperature;
    return '${temperature.round()}°';
  }

  String get icon {
    final icon = isToday ? _forecast.icon : _forecast.commonIcon;
    return 'http://openweathermap.org/img/wn/$icon@2x.png';
  }

  String get windSpeed {
    final speed = isToday ? _forecast.windSpeed : _forecast.averageWindSpeed;
    return '${speed.round()} m/s';
  }

  String get humidity {
    final humidity = isToday ? _forecast.humidity : _forecast.averageHumidity;
    return '${humidity.round()}%';
  }

  String get pressure {
    final pressure = isToday ? _forecast.pressure : _forecast.averagePressure;
    return '${pressure.round()} hPa';
  }
}

class ForecastItem {
  final DailyAverage _dailyForecast;

  ForecastItem(this._dailyForecast);

  DailyAverage get dailyForecast => _dailyForecast;

  DateTime get date => _dailyForecast.date;

  String get convertedDate {
    final date = _dailyForecast.date.shortDayOfWeek;
    return date;
  }

  String get icon {
    final icon = _dailyForecast.commonIcon;
    return 'http://openweathermap.org/img/wn/$icon@2x.png';
  }

  String get temperature {
    final min = _dailyForecast.minTemperature;
    final max = _dailyForecast.maxTemperature;
    return '${min.round()}° / ${max.round()}°';
  }
}

enum WeatherUnit { metric, imperial }
