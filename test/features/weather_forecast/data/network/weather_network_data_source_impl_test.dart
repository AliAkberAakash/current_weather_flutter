import 'dart:convert';

import 'package:current_weather/core/exceptions/network_exceptions.dart';
import 'package:current_weather/core/exceptions/server_exception.dart';
import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/core/network/network_request.dart';
import 'package:current_weather/core/network/network_response.dart';
import 'package:current_weather/features/current_weather/data/network/dto/current_weather_response.dart';
import 'package:current_weather/features/current_weather/data/network/current_weather_network_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/common_mocks.dart';
import 'json_response.dart';

class _MockNetworkClient extends Mock implements NetworkClient {}

void main() {
  late _MockNetworkClient networkClient;
  late MockLogger logger;
  late CurrentNetworkDataSourceImpl weatherNetworkDataSource;

  setUp(() {
    networkClient = _MockNetworkClient();
    logger = MockLogger();
    weatherNetworkDataSource = CurrentNetworkDataSourceImpl(
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
        var expectedResult = const [
          CurrentWeatherResponse(
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

        final result = await weatherNetworkDataSource.getWeatherResponse(
          lat: 50.221291,
          lon: 9.968617,
          unit: "metric",
        );

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

        expect(
          weatherNetworkDataSource.getWeatherResponse(
            lat: 50.221291,
            lon: 9.968617,
            unit: "metric",
          ),
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

        expect(
          weatherNetworkDataSource.getWeatherResponse(
            lat: 50.221291,
            lon: 9.968617,
            unit: "metric",
          ),
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

        expect(
          weatherNetworkDataSource.getWeatherResponse(
            lat: 50.221291,
            lon: 9.968617,
            unit: "metric",
          ),
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

        expect(
          weatherNetworkDataSource.getWeatherResponse(
            lat: 50.221291,
            lon: 9.968617,
            unit: "metric",
          ),
          throwsA(isA<FormatException>()),
        );

        verify(
          () => networkClient.get(mockNetworkRequest),
        ).called(1);
      });
    });
  });
}
