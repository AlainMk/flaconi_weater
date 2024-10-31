import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flaconi_weather/shared/models/repository_error.dart';
import 'package:flaconi_weather/shared/repository/base_repository.dart';
import 'package:flaconi_weather/weather/data/api/weather_api.dart';
import 'package:flaconi_weather/weather/data/models/daily_average.dart';
import 'package:flaconi_weather/weather/data/models/daily_weather.dart';
import 'package:flaconi_weather/weather/data/models/forecast.dart';
import 'package:flaconi_weather/weather/data/service/location_service.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class WeatherRepository extends BaseRepository {
  final WeatherApi _api = GetIt.instance.get<WeatherApi>();
  final LocationService _locationService = GetIt.instance.get<LocationService>();

  Future<Either<RepositoryError, DailyWeather>> getWeatherByCity(String city, {String units = 'metric'}) async {
    try {
      final response = await _api.getWeatherByCity(city, units: units);
      return Right(DailyWeather.fromJson(response.data));
    } catch (error, stackTrace) {
      return Left(
        handleError(
          location: '$runtimeType.getWeatherByCity()',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Either<RepositoryError, DailyWeather>> getWeatherByLocation({String units = 'metric'}) async {
    try {
      final location = await _locationService.getCurrentLocation();
      if (location == null) {
        return Left(RepositoryError(error: 'Location not found'));
      }
      final response = await _api.getWeatherByLocation(location.latitude!, location.longitude!, units: units);
      return Right(DailyWeather.fromJson(response.data));
    } catch (error, stackTrace) {
      return Left(
        handleError(
          location: '$runtimeType.getWeatherByLocation()',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<Either<RepositoryError, List<DailyAverage>>> getSevenDayForecastByCity(String city, {String units = 'metric'}) async {
    try {
      final response = await _api.getSevenDayForecastByCity(city, units: units);
      final forecast = Forecast.fromJson(response.data);
      return Right(calculateDailyAverages(forecast.list!.map((e) => e.toLocalForecast()).toList()));
    } catch (error, stackTrace) {
      return Left(
        handleError(
          location: '$runtimeType.getSevenDayForecastByCity()',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  List<DailyAverage> calculateDailyAverages(List<LocalForecast> forecasts) {
    Map<String, List<LocalForecast>> groupedByDay = {};

    // Group forecasts by day
    for (var forecast in forecasts) {
      String dayKey = DateFormat('yyyy-MM-dd').format(forecast.dateTime);
      if (!groupedByDay.containsKey(dayKey)) {
        groupedByDay[dayKey] = [];
      }
      groupedByDay[dayKey]!.add(forecast);
    }

    // Calculate daily averages
    List<DailyAverage> dailyAverages = [];

    groupedByDay.forEach((day, dailyForecasts) {
      double minTemp = dailyForecasts.map((f) => f.temperature).reduce(min);
      double maxTemp = dailyForecasts.map((f) => f.temperature).reduce(max);

      // Determine the most common icon of the day
      Map<String, int> iconCounts = {};
      for (var forecast in dailyForecasts) {
        iconCounts[forecast.icon] = (iconCounts[forecast.icon] ?? 0) + 1;
      }
      String mostCommonIcon = iconCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      dailyAverages.add(DailyAverage(
        date: DateFormat('yyyy-MM-dd').parse(day),
        minTemperature: minTemp,
        maxTemperature: maxTemp,
        icon: mostCommonIcon,
      ));
    });

    return dailyAverages;
  }
}
