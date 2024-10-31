import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/weather/ui/blocs/daily/daily_weather_bloc.dart';
import 'package:flaconi_weather/weather/ui/city_content.dart';
import 'package:flaconi_weather/weather/ui/info_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SuccessWeatherContainer extends StatelessWidget {
  const SuccessWeatherContainer({super.key, required this.weatherState});

  final SuccessDailyWeatherState weatherState;

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
