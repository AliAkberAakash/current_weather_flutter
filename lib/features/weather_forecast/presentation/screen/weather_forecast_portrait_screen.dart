import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_details_cubit.dart';
import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/weather_forecast/presentation/widget/weather_day_info_widget.dart';
import 'package:current_weather/features/weather_forecast/presentation/widget/weather_details_widget.dart';
import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherForecastPortraitScreen extends StatelessWidget {
  final WeatherDetailsCubit weatherDetailsCubit;
  final List<WeatherDetailsUiModel> weatherDetailsUiModelList;

  const WeatherForecastPortraitScreen({
    super.key,
    required this.weatherDetailsUiModelList,
    required this.weatherDetailsCubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.all(
        theme.spacingTokens.cwSpacing16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: BlocBuilder<WeatherDetailsCubit, WeatherDetailsUiModel?>(
              bloc: weatherDetailsCubit,
              builder: (ctx, state) {
                if (state != null) {
                  return WeatherDetailsWidget(
                    weatherDetailsUiModel: state,
                  );
                } else {
                  // todo: add a shimmer
                  return const SizedBox();
                }
              },
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weatherDetailsUiModelList.length,
              itemBuilder: (BuildContext context, int index) {
                return WeatherDayInfoWidget(
                  uiModel: weatherDetailsUiModelList[index],
                  onTap: weatherDetailsCubit.updateWeatherDetails,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
