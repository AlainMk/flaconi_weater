import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/weather/ui/city_content.dart';
import 'package:flaconi_weather/weather/ui/info_content.dart';
import 'package:flaconi_weather/weather/ui/next_forecast.dart';
import 'package:flaconi_weather/widgets/circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlaconiCircleButton(
              onPressed: () {},
              size: 45,
              icon: CupertinoIcons.location_fill,
            ),
            const Spacer(),
            const Icon(Icons.cloud),
            const SizedBox(width: FlaconiSpacing.smallMedium),
            const Text('Weather'),
            const Spacer(),
            FlaconiCircleButton(
              onPressed: () {},
              size: 45,
              icon: Icons.more_vert,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(FlaconiSpacing.normal),
            WeatherCityContainer(
              city: 'London',
              onTap: () {},
            ),
            const Gap(FlaconiSpacing.largeL),
            Text(
              'Today',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CachedNetworkImage(
              imageUrl: "https://openweathermap.org/img/wn/10d@2x.png",
              height: 200,
              fit: BoxFit.cover,
            ),
            const Gap(FlaconiSpacing.largeL),
            Text(
              '25°',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Cloudy',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: FlaconiColors.lightGray),
            ),
            const Gap(FlaconiSpacing.largeXl),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherInfoContainer(
                  title: 'Wind',
                  value: '5 km/h',
                  icon: Icons.air,
                ),
                WeatherInfoContainer(
                  title: 'Humidity',
                  value: '50%',
                  icon: Icons.water,
                ),
                WeatherInfoContainer(
                  title: 'Pressure',
                  value: '1013 hPa',
                  icon: Icons.speed,
                ),
              ],
            ),
            const Gap(FlaconiSpacing.largeXxl),
            const NextForecastContent(),
            const Gap(FlaconiSpacing.largeXl),
          ],
        ),
      ),
    );
  }
}
