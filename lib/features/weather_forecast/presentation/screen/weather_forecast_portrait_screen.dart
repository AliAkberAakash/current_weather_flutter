import 'package:current_weather/features/weather_forecast/presentation/bloc/weather_details_cubit.dart';
import 'package:current_weather/features/weather_forecast/presentation/model/weather_details_ui_model.dart';
import 'package:current_weather/features/weather_forecast/presentation/widget/weather_day_info_widget.dart';
import 'package:current_weather/features/weather_forecast/presentation/widget/weather_details_widget.dart';
import 'package:current_weather_design_system/styles/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WeatherForecastPortraitScreen extends StatefulWidget {
  final WeatherDetailsCubit weatherDetailsCubit;
  final List<WeatherDetailsUiModel> weatherDetailsUiModelList;
  final void Function() onRefresh;

  const WeatherForecastPortraitScreen({
    super.key,
    required this.weatherDetailsUiModelList,
    required this.weatherDetailsCubit,
    required this.onRefresh,
  });

  @override
  State<WeatherForecastPortraitScreen> createState() =>
      _WeatherForecastPortraitScreenState();
}

class _WeatherForecastPortraitScreenState
    extends State<WeatherForecastPortraitScreen> {
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: BlocBuilder<WeatherDetailsCubit, WeatherDetailsUiModel?>(
                bloc: widget.weatherDetailsCubit,
                builder: (ctx, state) {
                  if (state != null) {
                    return WeatherDetailsWidget(
                      onTemperatureUnitChange: () {},
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
                itemCount: widget.weatherDetailsUiModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  return WeatherDayInfoWidget(
                    uiModel: widget.weatherDetailsUiModelList[index],
                    onTap: widget.weatherDetailsCubit.updateWeatherDetails,
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
