import 'package:bloc_test/bloc_test.dart';
import 'package:current_weather/features/common/domain/error/error.dart';
import 'package:current_weather/features/current_weather/domain/entity/weather_details_entity.dart';
import 'package:current_weather/features/current_weather/domain/use_case/current_weather_use_case.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_bloc.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_event.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_state.dart';
import 'package:current_weather/features/current_weather/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrentWeatherUseCase extends Mock implements CurrentWeatherUseCase {}

void main() {
  late WeatherListBloc weatherListBloc;
  late CurrentWeatherUseCase currentWeatherUseCase;

  group("WeatherListBloc", () {
    setUp(() {
      currentWeatherUseCase = MockCurrentWeatherUseCase();
      weatherListBloc = WeatherListBloc(currentWeatherUseCase);
    });

    test("Initial state is WeatherListLoadingState", () {
      expect(weatherListBloc.state, WeatherListLoadingState());
      verifyZeroInteractions(currentWeatherUseCase);
    });

    group("on<WeatherListLoadEvent>", () {
      group("CurrentWeatherUseCase throws exception", () {
        blocTest(
          "emits [WeatherListLoadingState,WeatherListErrorState(errorKey: ErrorKey.serverError)] when useCase throws ServerException",
          build: () => weatherListBloc,
          setUp: () {
            when(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).thenThrow(ServerError());
          },
          act: (bloc) => bloc.add(WeatherListLoadEvent()),
          expect: () => <WeatherListState>[
            WeatherListLoadingState(),
            WeatherListErrorState(
              error: ServerError(),
            ),
          ],
          verify: (_) {
            verify(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).called(1);
          },
        );

        blocTest(
          "emits [WeatherListLoadingState,WeatherListErrorState(errorKey: ErrorKey.networkError)] when useCase throws NetworkException",
          build: () => weatherListBloc,
          setUp: () {
            when(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).thenThrow(NetworkError());
          },
          act: (bloc) => bloc.add(WeatherListLoadEvent()),
          expect: () => <WeatherListState>[
            WeatherListLoadingState(),
            WeatherListErrorState(
              error: NetworkError(),
            ),
          ],
          verify: (_) {
            verify(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).called(1);
          },
        );

        blocTest(
          "emits [WeatherListLoadingState,WeatherListErrorState(errorKey: ErrorKey.networkTimeOutError)] when useCase throws NetworkTimeoutException",
          build: () => weatherListBloc,
          setUp: () {
            when(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).thenThrow(NetworkTimeoutError());
          },
          act: (bloc) => bloc.add(WeatherListLoadEvent()),
          expect: () => <WeatherListState>[
            WeatherListLoadingState(),
            WeatherListErrorState(
              error: NetworkTimeoutError(),
            ),
          ],
          verify: (_) {
            verify(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).called(1);
          },
        );

        blocTest(
          "emits [WeatherListLoadingState,WeatherListErrorState(errorKey: ErrorKey.commonError)] when useCase throws any other Exception",
          build: () => weatherListBloc,
          setUp: () {
            when(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).thenThrow(CommonError());
          },
          act: (bloc) => bloc.add(WeatherListLoadEvent()),
          expect: () => <WeatherListState>[
            WeatherListLoadingState(),
            WeatherListErrorState(
              error: CommonError(),
            ),
          ],
          verify: (_) {
            verify(
              () => currentWeatherUseCase.getWeatherDetails(
                10.2,
                -20.3,
                MeasurementUnit.metric,
              ),
            ).called(1);
          },
        );
      });

      final weatherDetailsUiModel = WeatherDetailsUiModel(
        dayNameFull: "Sunday",
        dayNameShort: "Sun",
        temp: "25.50°",
        tempMin: "20.00°",
        tempMax: "30.00°",
        pressure: "1013 hPa",
        humidity: "65 %",
        partOfDay: "Morning",
        weatherCondition: "Cloudy",
        description: "Overcast clouds",
        smallIcon: "https://openweathermap.org/img/wn/cloud_icon.png@2x.png",
        bigIcon: "https://openweathermap.org/img/wn/cloud_icon.png@4x.png",
        windSpeed: "5.50 m/s",
        measurementUnit: MeasurementUnit.metric,
        temperatureUnit: "°C",
      );
      final weatherDetailsEntity = WeatherDetailsEntity(
        dateTime: 1731196800,
        temp: 25.5,
        tempMin: 20.0,
        tempMax: 30.0,
        pressure: 1013,
        humidity: 65,
        partOfDay: "Morning",
        weather: [
          WeatherEntity(
            name: "Cloudy",
            description: "Overcast clouds",
            icon: "cloud_icon.png",
          )
        ],
        speed: 5.5,
        unit: MeasurementUnit.metric,
      );
      blocTest(
        "CurrentWeatherUseCase returns proper response",
        build: () => weatherListBloc,
        setUp: () {
          when(
            () => currentWeatherUseCase.getWeatherDetails(
              10.2,
              -20.3,
              MeasurementUnit.metric,
            ),
          ).thenAnswer(
            (_) => Future.value([
              weatherDetailsEntity,
            ]),
          );
        },
        act: (bloc) => bloc.add(WeatherListLoadEvent()),
        expect: () => <WeatherListState>[
          WeatherListLoadingState(),
          WeatherListLoadedState([weatherDetailsUiModel]),
        ],
        verify: (_) {
          verify(
            () => currentWeatherUseCase.getWeatherDetails(
              10.2,
              -20.3,
              MeasurementUnit.metric,
            ),
          ).called(1);
        },
      );
    });
  });
}
