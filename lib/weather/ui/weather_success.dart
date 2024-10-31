import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/weather/ui/bloc/forecast_bloc.dart';
import 'package:flaconi_weather/weather/ui/widgets/city_content.dart';
import 'package:flaconi_weather/weather/ui/widgets/info_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SuccessWeatherContainer extends StatelessWidget {
  const SuccessWeatherContainer({super.key, required this.state});

  final SuccessForecastState state;

  @override
  Widget build(BuildContext context) {
    final details = state.selectedForecastDetails;
    return Column(
      children: [
        const Gap(FlaconiSpacing.smallMedium),
        WeatherCityContainer(
          city: state.cityName ?? "Current Location",
          onTap: (v) {
            if (v.isEmpty) return;
            context.read<ForecastBloc>().add(GetForecastByCity(v, units: state.units));
          },
        ),
        const Gap(FlaconiSpacing.large),
        Text(
          details.convertedDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        CachedNetworkImage(
          imageUrl: details.icon,
          height: 180,
          fit: BoxFit.cover,
        ),
        const Gap(FlaconiSpacing.large),
        Text(
          details.temperature,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          details.weatherCondition,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: FlaconiColors.lightGray),
        ),
        const Gap(FlaconiSpacing.largeL),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WeatherInfoContainer(
              title: 'Wind',
              value: details.windSpeed,
              icon: Icons.air,
            ),
            WeatherInfoContainer(
              title: 'Humidity',
              value: details.humidity,
              icon: Icons.water,
            ),
            WeatherInfoContainer(
              title: 'Pressure',
              value: details.pressure,
              icon: Icons.speed,
            ),
          ],
        ),
      ],
    );
  }
}
