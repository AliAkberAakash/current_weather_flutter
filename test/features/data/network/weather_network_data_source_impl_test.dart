import 'dart:convert';

import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/core/network/network_request.dart';
import 'package:current_weather/core/network/network_response.dart';
import 'package:current_weather/features/weather_forecast/data/network/dto/weather_query_request.dart';
import 'package:current_weather/features/weather_forecast/data/network/dto/weekly_weather_response.dart';
import 'package:current_weather/features/weather_forecast/data/network/weather_network_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/common_mocks.dart';
import 'json_response.dart';

class _MockNetworkClient extends Mock implements NetworkClient {}

void main() {
  group("WeatherNetworkDataSourceImpl", () {
    late final _MockNetworkClient networkClient;
    late final MockLogger logger;
    late final weatherNetworkDataSource = WeatherNetworkDataSourceImpl(
      networkClient,
      logger,
    );

    setUp(() {
      networkClient = _MockNetworkClient();
      logger = MockLogger();
    });

    group("getWeatherResponse", () {
      test(
          "getWeatherResponse returns WeeklyWeatherResponse when succes request",
          () async {
        const mockNetworkRequest =
            NetworkRequest(url: "forecast", queryParams: {
          "lat": "50.221291",
          "lon": "9.968617",
          "appId": "112b57f4be025fddcb03a568ee3b40a6",
        });
        final mockResponse = NetworkResponse(
          body: jsonDecode(jsonResponse),
          headers: {
            "Content-Type": ["application/json"]
          },
        );
        when(() => networkClient.get(mockNetworkRequest))
            .thenAnswer((_) async => mockResponse);
        const WeatherQueryRequest actualRequest = WeatherQueryRequest(
          50.221291,
          9.968617,
        );
        var expectedResult = const [
          WeeklyWeatherResponse(
            dateTime: 1730548800,
            weatherDetails: WeatherDetails(
              tempMin: 283.81,
              tempMax: 284.24,
              pressure: 1030,
              humidity: 86,
            ),
            weather: [
              Weather(
                name: "Clouds",
                description: "overcast clouds",
                icon: "04d",
              )
            ],
            wind: Wind(speed: 1.22),
            sys: Sys(partOfDay: "d"),
          ),
        ];

        final result =
            await weatherNetworkDataSource.getWeatherResponse(actualRequest);

        expect(result, expectedResult);
        verify(
          () => networkClient.get(mockNetworkRequest),
        ).called(1);
      });
    });
  });
}
