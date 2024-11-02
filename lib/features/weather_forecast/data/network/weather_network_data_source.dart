import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/core/network/network_request.dart';
import 'package:current_weather/features/weather_forecast/data/network/dto/weekly_weather_response.dart';
import 'package:logger/logger.dart';

abstract class WeatherNetworkDataSource {
  Future<WeeklyWeatherResponse> getWeatherResponse();
}

class WeatherNetworkDataSourceImpl implements WeatherNetworkDataSource {
  final NetworkClient _networkClient;
  final Logger _logger;

  WeatherNetworkDataSourceImpl(
    this._networkClient,
    this._logger,
  );

  @override
  Future<WeeklyWeatherResponse> getWeatherResponse() async {
    try {
      const networkRequest = NetworkRequest(
        url: "forecast",
        queryParams: {
          "lat": "-33.439",
          "lon": "-70.6432",
          "appId": "112b57f4be025fddcb03a568ee3b40a6",
        },
      );
      final response = await _networkClient.get(networkRequest);
      return WeeklyWeatherResponse.fromJson(response.body);
    } catch (e) {
      _logger.d(e.toString());
      rethrow;
    }
  }
}
