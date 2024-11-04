import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/core/network/network_request.dart';
import 'package:current_weather/env.dart';
import 'package:current_weather/features/current_weather/data/network/dto/weekly_weather_response.dart';
import 'package:current_weather/features/current_weather/data/network/weather_network_data_source.dart';
import 'package:logger/logger.dart';

class WeatherNetworkDataSourceImpl implements WeatherNetworkDataSource {
  final NetworkClient _networkClient;
  final Logger _logger;

  WeatherNetworkDataSourceImpl(
    this._networkClient,
    this._logger,
  );

  @override
  Future<List<WeeklyWeatherResponse>> getWeatherResponse(
    double lat,
    double lon,
    String unit,
  ) async {
    try {
      final networkRequest = NetworkRequest(
        url: "forecast",
        queryParams: {
          "lat": lat.toString(),
          "lon": lon.toString(),
          "appId": apiKey,
          "units": unit,
        },
      );
      final response = await _networkClient.get(networkRequest);
      final weatherDataList = response.body["list"];
      final List<WeeklyWeatherResponse> weatherList = [];

      for (var weatherData in weatherDataList) {
        weatherList.add(WeeklyWeatherResponse.fromJson(weatherData));
      }

      return weatherList;
    } catch (e) {
      _logger.d(e.toString());
      rethrow;
    }
  }
}
