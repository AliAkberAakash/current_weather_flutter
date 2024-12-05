import 'package:current_weather/core/exceptions/network_exceptions.dart';
import 'package:current_weather/core/exceptions/server_exception.dart';
import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/domain/repository/current_weather_repository.dart';
import 'package:current_weather/features/current_weather/domain/use_case/current_weather_use_case_impl.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherForecastRepository extends Mock
    implements CurrentWeatherRepository {}

void main() {
  late CurrentWeatherUseCaseImpl useCase;
  late MockWeatherForecastRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherForecastRepository();
    useCase = CurrentWeatherUseCaseImpl(mockRepository);
  });

  group(
    'WeatherForecastUseCaseImpl',
    () {
      const double lat = 52.52;
      const double lon = 13.405;
      const MeasurementUnit unit = MeasurementUnit.metric;
      const weatherDetailsEntityList = [
        WeatherDetailsEntity(
          dateTime: 1234567890,
          tempMin: 15.0,
          tempMax: 25.0,
          pressure: 1012,
          humidity: 85,
          partOfDay: 'd',
          weather: [
            WeatherEntity(
              name: 'Clear',
              description: 'clear sky',
              icon: '01d',
            )
          ],
          speed: 5.0,
          unit: MeasurementUnit.metric,
          temp: 15.0,
        ),
      ];

      test(
        'getWeatherDetails returns list of WeatherDetailsEntity when repository call succeeds',
        () async {
          when(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).thenAnswer((_) async => weatherDetailsEntityList);

          final result = await useCase.getWeatherDetails(
            lat: lat,
            lon: lon,
            unit: unit,
          );

          expect(result, equals(weatherDetailsEntityList));
          verify(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).called(1);
        },
      );

      test(
        'getWeatherDetails throws NetworkException when repository call throws NetworkException',
        () async {
          when(() => mockRepository.getWeatherDetails(
                lat: lat,
                lon: lon,
                unit: unit,
              )).thenThrow(const NetworkException());

          expect(
            () => useCase.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
            throwsA(isA<NetworkException>()),
          );
          verify(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).called(1);
        },
      );

      test(
        'getWeatherDetails throws NetworkTimeoutException when repository call throws NetworkTimeoutException',
        () async {
          when(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).thenThrow(const NetworkTimeoutException());

          expect(
            () => useCase.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
            throwsA(isA<NetworkTimeoutException>()),
          );
          verify(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).called(1);
        },
      );

      test(
        'getWeatherDetails throws ServerException when repository call throws ServerException',
        () async {
          when(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).thenThrow(const ServerException());

          expect(
            () => useCase.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
            throwsA(isA<ServerException>()),
          );
          verify(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).called(1);
        },
      );

      test(
        'getWeatherDetails throws FormatException when repository call throws FormatException',
        () async {
          when(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).thenThrow(const FormatException());

          expect(
            () => useCase.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
            throwsA(isA<FormatException>()),
          );
          verify(
            () => mockRepository.getWeatherDetails(
              lat: lat,
              lon: lon,
              unit: unit,
            ),
          ).called(1);
        },
      );
    },
  );
}
