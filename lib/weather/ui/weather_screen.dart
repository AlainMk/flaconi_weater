import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/theme/utils.dart';
import 'package:flaconi_weather/weather/ui/bloc/forecast_bloc.dart';
import 'package:flaconi_weather/weather/ui/error_screen.dart';
import 'package:flaconi_weather/weather/ui/forecast_list.dart';
import 'package:flaconi_weather/weather/ui/weather_success.dart';
import 'package:flaconi_weather/widgets/circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForecastBloc()..add(const GetForecastByLocation()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlaconiCircleButton(
                    onPressed: () {
                      context.read<ForecastBloc>().add(const GetForecastByLocation());
                    },
                    icon: CupertinoIcons.location_fill,
                  ),
                  const Spacer(),
                  const Icon(Icons.cloud),
                  const SizedBox(width: FlaconiSpacing.smallMedium),
                  const Text('Weather'),
                  const Spacer(),
                  FlaconiCircleButton(
                    onPressed: () {},
                    icon: Icons.more_vert,
                  ),
                ],
              ),
            ),
            body: BlocConsumer<ForecastBloc, ForecastState>(
              listener: (context, state) {
                if (state is ErrorForecastState) {
                  showErrorSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is LoadingForecastState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorForecastState) {
                  return WeatherErrorScreen(message: state.message);
                }

                final weatherState = state as SuccessForecastState;
                return RefreshIndicator(
                  onRefresh: () async {
                    if (weatherState.cityName == null) {
                      context.read<ForecastBloc>().add(const GetForecastByLocation());
                    } else {
                      context.read<ForecastBloc>().add(GetForecastByCity(weatherState.cityName!));
                    }
                  },
                  child: ListView(
                    children: [
                      SuccessWeatherContainer(state: weatherState),
                      const Gap(FlaconiSpacing.largeXl),
                      const ForecastListContent(),
                      const Gap(FlaconiSpacing.largeXl),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
