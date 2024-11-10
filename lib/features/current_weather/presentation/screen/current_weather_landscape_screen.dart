import 'package:current_weather/features/current_weather/presentation/bloc/weather_details_cubit.dart';
import 'package:current_weather/features/current_weather/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/current_weather/presentation/widget/weather_day_info_widget.dart';
import 'package:current_weather/features/current_weather/presentation/widget/weather_details_widget.dart';
import 'package:current_weather/features/current_weather/util/measurement_unit.dart';
import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CurrentWeatherLandscapeScreen extends StatefulWidget {
  final List<WeatherDetailsUiModel> weatherDetailsUiModelList;
  final void Function() onRefresh;
  final void Function(MeasurementUnit unit) onTemperatureUnitChange;

  const CurrentWeatherLandscapeScreen({
    super.key,
    required this.weatherDetailsUiModelList,
    required this.onRefresh,
    required this.onTemperatureUnitChange,
  });

  @override
  State<CurrentWeatherLandscapeScreen> createState() =>
      _CurrentWeatherLandscapeScreenState();
}

class _CurrentWeatherLandscapeScreenState
    extends State<CurrentWeatherLandscapeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: widget.onRefresh,
      child: Padding(
        padding: EdgeInsets.all(
          theme.spacingTokens.cwSpacing16,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: BlocBuilder<WeatherDetailsCubit, WeatherDetailsUiModel?>(
                builder: (ctx, state) {
                  if (state != null) {
                    return WeatherDetailsWidget(
                      onTemperatureUnitChange: () =>
                          widget.onTemperatureUnitChange(
                        state.measurementUnit,
                      ),
                      weatherDetailsUiModel: state,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            SizedBox(
              width: theme.spacingTokens.cwSpacing8,
            ),
            SizedBox(
              width: 200,
              child: ListView.builder(
                itemCount: widget.weatherDetailsUiModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return WeatherDayInfoWidget(
                    uiModel: widget.weatherDetailsUiModelList[index],
                    onTap: context
                        .read<WeatherDetailsCubit>()
                        .updateWeatherDetails,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
