import 'package:dio/dio.dart';

class WeatherApi {
  static const String _weatherPath = '/weather';
  static const String _forecastPath = '/forecast';
  final Dio _dio;

  WeatherApi(this._dio);

  Future<Response> getWeatherByCity(String city, {String units = 'metric'}) async {
    return _dio.get(_weatherPath, queryParameters: {'q': city, 'units': units});
  }

  Future<Response> getWeatherByLocation(double lat, double lon, {String units = 'metric'}) async {
    return _dio.get(_weatherPath, queryParameters: {'lat': lat, 'lon': lon, 'units': units});
  }

  Future<Response> getSixDayForecastByCity(String city, {String units = 'metric'}) async {
    return _dio.get(_forecastPath, queryParameters: {'q': city, 'units': units});
  }

  Future<Response> getSixDayForecastByLocation(double lat, double lon, {String units = 'metric'}) async {
    return _dio.get(_forecastPath, queryParameters: {'lat': lat, 'lon': lon, 'units': units});
  }
}
