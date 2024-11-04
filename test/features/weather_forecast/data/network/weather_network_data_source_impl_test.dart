import 'dart:convert';

import 'package:current_weather/core/exceptions/network_exceptions.dart';
import 'package:current_weather/core/exceptions/server_exception.dart';
import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/core/network/network_request.dart';
import 'package:current_weather/core/network/network_response.dart';
import 'package:current_weather/features/current_weather/data/network/dto/weather_query_request.dart';
import 'package:current_weather/features/current_weather/data/network/dto/weekly_weather_response.dart';
import 'package:current_weather/features/current_weather/data/network/weather_network_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/common_mocks.dart';
import 'json_response.dart';

class _MockNetworkClient extends Mock implements NetworkClient {}

void main() {
  late _MockNetworkClient networkClient;
  late MockLogger logger;
  late WeatherNetworkDataSourceImpl weatherNetworkDataSource;

  setUp(() {
    networkClient = _MockNetworkClient();
    logger = MockLogger();
    weatherNetworkDataSource = WeatherNetworkDataSourceImpl(
      networkClient,
      logger,
    );
  });

  group("WeatherNetworkDataSourceImpl", () {
    group("getWeatherResponse", () {
      test(
          "getWeatherResponse returns WeeklyWeatherResponse when success request",
          () async {
        const mockNetworkRequest = NetworkRequest(
          url: "forecast",
          queryParams: {
            "lat": "50.221291",
            "lon": "9.968617",
            "appId": "112b57f4be025fddcb03a568ee3b40a6",
          },
        );
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
          "metric",
        );
        var expectedResult = const [
          WeeklyWeatherResponse(
            dateTime: 1730548800,
            weatherDetails: WeatherDetails(
              temp: 15.0,
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

      test(
          "getWeatherResponse throws NetworkException when NetworkClient throws NetworkException",
          () async {
        const mockNetworkRequest = NetworkRequest(
          url: "forecast",
          queryParams: {
            "lat": "50.221291",
            "lon": "9.968617",
            "appId": "112b57f4be025fddcb03a568ee3b40a6",
          },
        );

        when(() => networkClient.get(mockNetworkRequest))
            .thenThrow(const NetworkException());

        const WeatherQueryRequest actualRequest = WeatherQueryRequest(
          50.221291,
          9.968617,
          "metric",
        );

        expect(
          weatherNetworkDataSource.getWeatherResponse(actualRequest),
          throwsA(isA<NetworkException>()),
        );

        verify(
          () => networkClient.get(mockNetworkRequest),
        ).called(1);
      });

      test(
          "getWeatherResponse throws NetworkTimeoutException when NetworkClient throws NetworkTimeoutException",
          () async {
        const mockNetworkRequest = NetworkRequest(
          url: "forecast",
          queryParams: {
            "lat": "50.221291",
            "lon": "9.968617",
            "appId": "112b57f4be025fddcb03a568ee3b40a6",
          },
        );

        when(() => networkClient.get(mockNetworkRequest))
            .thenThrow(const NetworkTimeoutException());

        const WeatherQueryRequest actualRequest = WeatherQueryRequest(
          50.221291,
          9.968617,
          "metric",
        );

        expect(
          weatherNetworkDataSource.getWeatherResponse(actualRequest),
          throwsA(isA<NetworkTimeoutException>()),
        );

        verify(
          () => networkClient.get(mockNetworkRequest),
        ).called(1);
      });

      test(
          "getWeatherResponse throws ServerException when NetworkClient throws ServerException",
          () async {
        const mockNetworkRequest = NetworkRequest(
          url: "forecast",
          queryParams: {
            "lat": "50.221291",
            "lon": "9.968617",
            "appId": "112b57f4be025fddcb03a568ee3b40a6",
          },
        );

        when(() => networkClient.get(mockNetworkRequest))
            .thenThrow(const ServerException());

        const WeatherQueryRequest actualRequest = WeatherQueryRequest(
          50.221291,
          9.968617,
          "metric",
        );

        expect(
          weatherNetworkDataSource.getWeatherResponse(actualRequest),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => networkClient.get(mockNetworkRequest),
        ).called(1);
      });

      test(
          "getWeatherResponse rethrows any other exception when NetworkClient throws exception",
          () async {
        const mockNetworkRequest = NetworkRequest(
          url: "forecast",
          queryParams: {
            "lat": "50.221291",
            "lon": "9.968617",
            "appId": "112b57f4be025fddcb03a568ee3b40a6",
          },
        );

        when(() => networkClient.get(mockNetworkRequest))
            .thenThrow(const FormatException());

        const WeatherQueryRequest actualRequest = WeatherQueryRequest(
          50.221291,
          9.968617,
          "metric",
        );

        expect(
          weatherNetworkDataSource.getWeatherResponse(actualRequest),
          throwsA(isA<FormatException>()),
        );

        verify(
          () => networkClient.get(mockNetworkRequest),
        ).called(1);
      });
    });
  });
}
