import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi_weather/theme/border_radius.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NextForecastContent extends StatelessWidget {
  const NextForecastContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.large),
          alignment: Alignment.centerLeft,
          child: Text(
            '7 Days Forecast',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Gap(FlaconiSpacing.largeXl),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            padding: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.large),
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.small),
                padding: const EdgeInsets.all(FlaconiSpacing.medium),
                decoration: BoxDecoration(
                  color: FlaconiColors.background,
                  borderRadius: BorderRadius.circular(FlaconiBorderRadius.huge),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mon',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: "https://openweathermap.org/img/wn/10d@2x.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      '15°/20°',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
