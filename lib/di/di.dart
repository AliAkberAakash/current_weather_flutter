import 'package:current_weather/core/network/dio_configuration.dart';
import 'package:current_weather/core/network/dio_network_client.dart';
import 'package:current_weather/core/network/network_client.dart';
import 'package:current_weather/features/current_weather/data/mapper/weather_details_entity_mapper.dart';
import 'package:current_weather/features/current_weather/data/network/weather_network_data_source.dart';
import 'package:current_weather/features/current_weather/data/network/weather_network_data_source_impl.dart';
import 'package:current_weather/features/current_weather/data/repository/weather_forecast_repository_impl.dart';
import 'package:current_weather/features/current_weather/domain/repository/weather_forecast_repository.dart';
import 'package:current_weather/features/current_weather/domain/use_case/weather_forecast_use_case.dart';
import 'package:current_weather/features/current_weather/domain/use_case/weather_forecast_use_case_impl.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_details_cubit.dart';
import 'package:current_weather/features/current_weather/presentation/bloc/weather_list/weather_list_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.I;

void setup() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      configureDio(),
    ),
  );

  getIt.registerLazySingleton<Logger>(
    () => Logger(),
  );

  getIt.registerLazySingleton<NetworkClient>(
    () => DioNetworkClient(
      getIt.get(),
      interceptors: [
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
        ),
      ],
    ),
  );

  getIt.registerLazySingleton<WeatherNetworkDataSource>(
    () => WeatherNetworkDataSourceImpl(
      getIt.get(),
      getIt.get(),
    ),
  );

  getIt.registerLazySingleton<WeatherDetailsEntityMapper>(
      () => WeatherDetailsEntityMapperImpl());

  getIt.registerLazySingleton<WeatherForecastRepository>(
    () => WeatherForecastRepositoryImpl(
      getIt.get(),
      getIt.get(),
      getIt.get(),
    ),
  );

  getIt.registerLazySingleton<WeatherForecastUseCase>(
    () => WeatherForecastUseCaseImpl(
      getIt.get(),
    ),
  );

  getIt.registerFactory<WeatherListBloc>(
    () => WeatherListBloc(
      getIt.get(),
    ),
  );

  getIt.registerFactory<WeatherDetailsCubit>(
    () => WeatherDetailsCubit(),
  );
}
