import 'package:dartz/dartz.dart';
import 'package:flaconi_weather/shared/models/repository_error.dart';
import 'package:flaconi_weather/shared/repository/base_repository.dart';
import 'package:flaconi_weather/weather/data/api/weather_api.dart';
import 'package:flaconi_weather/weather/data/models/daily_weather.dart';
import 'package:flaconi_weather/weather/data/models/forecast.dart';
import 'package:flaconi_weather/weather/data/service/location_service.dart';
import 'package:get_it/get_it.dart';

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

  Future<Either<RepositoryError, Forecast>> getSevenDayForecastByCity(String city, {String units = 'metric'}) async {
    try {
      final response = await _api.getSevenDayForecastByCity(city, units: units);
      return Right(Forecast.fromJson(response.data));
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

  Future<Either<RepositoryError, Forecast>> getSevenDayForecastByLocation({String units = 'metric'}) async {
    try {
      final location = await _locationService.getCurrentLocation();
      if (location == null) {
        return Left(RepositoryError(error: 'Location not found'));
      }
      final response = await _api.getSevenDayForecastByLocation(location.latitude!, location.longitude!, units: units);
      return Right(Forecast.fromJson(response.data));
    } catch (error, stackTrace) {
      return Left(
        handleError(
          location: '$runtimeType.getSevenDayForecastByLocation()',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
