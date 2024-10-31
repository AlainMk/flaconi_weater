import 'package:dio/dio.dart';
import 'package:flaconi_weather/weather/data/api/weather_api.dart';
import 'package:flaconi_weather/weather/data/repository/weather_repository.dart';
import 'package:flaconi_weather/weather/data/service/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';

class DependencyInjector {
  static void inject() {
    // Register Location Service
    GetIt.instance.registerSingleton<LocationService>(LocationService(Location()));

    // API's
    GetIt.instance.registerSingleton<WeatherApi>(WeatherApi(_createDio()));

    // Repositories
    GetIt.instance.registerSingleton<WeatherRepository>(WeatherRepository());
  }

  static Dio _createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "https://api.openweathermap.org/data/2.5",
        queryParameters: {'appid': '3b66a8f68fbbff5c9b3824bc74fc6cf4'},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("::: Api request : ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("::: Api response : ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint("::: Api error : $e");
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
