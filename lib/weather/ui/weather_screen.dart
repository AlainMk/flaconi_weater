import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/theme/utils.dart';
import 'package:flaconi_weather/weather/ui/blocs/daily/daily_weather_bloc.dart';
import 'package:flaconi_weather/weather/ui/city_content.dart';
import 'package:flaconi_weather/weather/ui/info_content.dart';
import 'package:flaconi_weather/weather/ui/next_forecast.dart';
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
      create: (context) => DailyWeatherBloc()..add(const GetDailyWeatherByLocation()),
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
                      const Gap(FlaconiSpacing.normal),
                      WeatherCityContainer(
                        city: weatherState.cityName,
                        onTap: () {},
                      ),
                      const Gap(FlaconiSpacing.largeL),
                      Text(
                        weatherState.date,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      CachedNetworkImage(
                        imageUrl: weatherState.icon,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const Gap(FlaconiSpacing.largeL),
                      Text(
                        weatherState.temperature,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        weatherState.weatherCondition,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: FlaconiColors.lightGray),
                      ),
                      const Gap(FlaconiSpacing.largeXl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherInfoContainer(
                            title: 'Wind',
                            value: weatherState.windSpeed,
                            icon: Icons.air,
                          ),
                          WeatherInfoContainer(
                            title: 'Humidity',
                            value: weatherState.humidity,
                            icon: Icons.water,
                          ),
                          WeatherInfoContainer(
                            title: 'Pressure',
                            value: weatherState.pressure,
                            icon: Icons.speed,
                          ),
                        ],
                      ),
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

class WeatherErrorScreen extends StatelessWidget {
  const WeatherErrorScreen({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(FlaconiSpacing.largeXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const Gap(FlaconiSpacing.normal),
            FlaconiCircleButton(
              onPressed: () {
                context.read<DailyWeatherBloc>().add(const GetDailyWeatherByLocation());
              },
              size: 45,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }
}
