import 'package:current_weather/core/exceptions/network_exceptions.dart';
import 'package:current_weather/core/exceptions/server_exception.dart';
import 'package:current_weather/features/weather_forecast/data/mapper/weather_details_entity_mapper.dart';
import 'package:current_weather/features/weather_forecast/data/network/dto/weather_query_request.dart';
import 'package:current_weather/features/weather_forecast/data/network/dto/weekly_weather_response.dart';
import 'package:current_weather/features/weather_forecast/data/network/weather_network_data_source.dart';
import 'package:current_weather/features/weather_forecast/data/repository/weather_forecast_repository_impl.dart';
import 'package:current_weather/features/weather_forecast/domain/entity/weather_details_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/common_mocks.dart';

class _MockWeatherNetworkDataSource extends Mock
    implements WeatherNetworkDataSource {}

class _MockWeatherDetailsEntityMapper extends Mock
    implements WeatherDetailsEntityMapper {}

void main() {
  late WeatherForecastRepositoryImpl repository;
  late _MockWeatherNetworkDataSource mockNetworkDataSource;
  late _MockWeatherDetailsEntityMapper mockMapper;
  late Logger mockLogger;

  group("WeatherForecastRepositoryImpl", () {
    setUp(() {
      mockNetworkDataSource = _MockWeatherNetworkDataSource();
      mockMapper = _MockWeatherDetailsEntityMapper();
      mockLogger = MockLogger();
      repository = WeatherForecastRepositoryImpl(
        mockNetworkDataSource,
        mockMapper,
        mockLogger,
      );
    });

    const mockRequest = WeatherQueryRequest(-10, -20);
    const weatherDetailsResponse = WeeklyWeatherResponse(
      dateTime: 1234567890,
      weatherDetails: WeatherDetails(
        tempMin: 15.0,
        tempMax: 25.0,
        pressure: 1012,
        humidity: 85,
      ),
      weather: [
        Weather(
          name: "Clear",
          description: "clear sky",
          icon: "01d",
        ),
      ],
      wind: Wind(speed: 5.0),
      sys: Sys(partOfDay: "d"),
    );
    const mockResponse = [weatherDetailsResponse];
    const weatherDetailsEntity = WeatherDetailsEntity(
      dateTime: 1234567890,
      tempMin: 15.0,
      tempMax: 25.0,
      pressure: 1012,
      humidity: 85,
      partOfDay: "d",
      weather: [
        WeatherEntity(
          name: "Clear",
          description: "clear sky",
          icon: "01d",
        ),
      ],
      speed: 5.0,
    );
    const expectedResult = [weatherDetailsEntity];

    test(
        "getWeatherDetails returns WeatherDetailsEntity when network data source returns WeatherDetailsResponse",
        () async {
      when(() => mockNetworkDataSource.getWeatherResponse(mockRequest))
          .thenAnswer((_) => Future.value(mockResponse));
      when(() =>
              mockMapper.mapFromWeeklyWeatherResponse(weatherDetailsResponse))
          .thenAnswer((_) => weatherDetailsEntity);

      final result = await repository.getWeatherDetails(
        -10,
        -20,
      );

      expect(result, expectedResult);
      verify(
        () => mockNetworkDataSource.getWeatherResponse(mockRequest),
      ).called(1);
      verify(
        () => mockMapper.mapFromWeeklyWeatherResponse(weatherDetailsResponse),
      ).called(1);
      verifyNever(
        () => mockLogger.d(any()),
      );
    });

    test(
        "getWeatherDetails throws NetworkException when network data source throws NetworkException",
        () async {
      when(() => mockNetworkDataSource.getWeatherResponse(mockRequest))
          .thenThrow(const NetworkException());

      expect(
        repository.getWeatherDetails(
          -10,
          -20,
        ),
        throwsA(isA<NetworkException>()),
      );
      verify(
        () => mockNetworkDataSource.getWeatherResponse(mockRequest),
      ).called(1);
      verifyNever(
        () => mockMapper.mapFromWeeklyWeatherResponse(weatherDetailsResponse),
      );
      verify(
        () => mockLogger.d("NetworkException()"),
      ).called(1);
    });

    test(
        "getWeatherDetails throws NetworkTimeoutException when network data source throws NetworkTimeoutException",
        () async {
      when(() => mockNetworkDataSource.getWeatherResponse(mockRequest))
          .thenThrow(const NetworkTimeoutException());

      expect(
        repository.getWeatherDetails(
          -10,
          -20,
        ),
        throwsA(isA<NetworkTimeoutException>()),
      );
      verify(
        () => mockNetworkDataSource.getWeatherResponse(mockRequest),
      ).called(1);
      verifyNever(
        () => mockMapper.mapFromWeeklyWeatherResponse(weatherDetailsResponse),
      );
      verify(
            () => mockLogger.d("NetworkTimeoutException()"),
      ).called(1);
    });

    test(
        "getWeatherDetails throws ServerException when network data source throws ServerException",
        () async {
      when(() => mockNetworkDataSource.getWeatherResponse(mockRequest))
          .thenThrow(const ServerException());

      expect(
        repository.getWeatherDetails(
          -10,
          -20,
        ),
        throwsA(isA<ServerException>()),
      );
      verify(
        () => mockNetworkDataSource.getWeatherResponse(mockRequest),
      ).called(1);
      verifyNever(
        () => mockMapper.mapFromWeeklyWeatherResponse(weatherDetailsResponse),
      );
      verify(
            () => mockLogger.d("ServerException(null, null)"),
      ).called(1);
    });

    test(
        "getWeatherDetails rethrows any other exception when network data source throws exception",
        () async {
      when(() => mockNetworkDataSource.getWeatherResponse(mockRequest))
          .thenThrow(const FormatException());

      expect(
        repository.getWeatherDetails(
          -10,
          -20,
        ),
        throwsA(isA<FormatException>()),
      );
      verify(
        () => mockNetworkDataSource.getWeatherResponse(mockRequest),
      ).called(1);
      verifyNever(
        () => mockMapper.mapFromWeeklyWeatherResponse(weatherDetailsResponse),
      );
      verify(
            () => mockLogger.d("FormatException"),
      ).called(1);
    });
  });
}
