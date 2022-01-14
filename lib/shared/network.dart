import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static double lon = 113.17;
  static double lat = 23.09;
  static init() {
    dio = Dio();
  }

  static Future<Response> getWeatherData({
    url = "http://www.7timer.info/bin/api.pl",
  }) async {
    return await dio!.get(
      url,
      queryParameters: {
        'lon': lon,
        'lat': lat,
        'product': 'astro',
        'output': 'json'
      },
    );
  }

  static Future<Response> geCityName({
    url = "http://api.openweathermap.org/geo/1.0/reverse",
  }) async {
    return await dio!.get(
      url,
      queryParameters: {
        'lon': lon,
        'lat': lat,
        'appid': '2988b238874f0e2b2d97cbc399acb93f'
      },
    );
  }
}
