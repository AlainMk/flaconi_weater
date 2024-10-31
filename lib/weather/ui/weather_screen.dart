import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/theme/utils.dart';
import 'package:flaconi_weather/weather/ui/blocs/daily/daily_weather_bloc.dart';
import 'package:flaconi_weather/weather/ui/blocs/forecast/forecast_bloc.dart';
import 'package:flaconi_weather/weather/ui/error_screen.dart';
import 'package:flaconi_weather/weather/ui/next_forecast.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DailyWeatherBloc()..add(const GetDailyWeatherByLocation())),
        BlocProvider(create: (context) => ForecastBloc()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlaconiCircleButton(
                    onPressed: () {
                      context.read<DailyWeatherBloc>().add(const GetDailyWeatherByLocation());
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
            body: BlocConsumer<DailyWeatherBloc, DailyWeatherState>(
              listener: (context, state) {
                if (state is ErrorDailyWeatherState) {
                  showErrorSnackBar(context, state.message);
                } else if (state is SuccessDailyWeatherState) {
                  final cityName = state.cityName;
                  context.read<ForecastBloc>().add(GetForecastByCity(cityName));
                }
              },
              builder: (context, state) {
                if (state is LoadingDailyWeatherState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorDailyWeatherState) {
                  return WeatherErrorScreen(message: state.message);
                }

                final weatherState = state as SuccessDailyWeatherState;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SuccessWeatherContainer(weatherState: weatherState),
                      const Gap(FlaconiSpacing.largeXxl),
                      const NextForecastContent(),
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
