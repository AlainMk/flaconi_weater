import 'package:flaconi_weather/theme/border_radius.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flutter/material.dart';

class WeatherCityContainer extends StatelessWidget {
  const WeatherCityContainer({
    super.key,
    required this.city,
    required this.onTap,
  });

  final String city;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: FlaconiColors.background,
          borderRadius: BorderRadius.circular(FlaconiBorderRadius.big),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(FlaconiBorderRadius.big),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.largeXl, vertical: FlaconiSpacing.small),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_city),
                  const SizedBox(width: FlaconiSpacing.smallMedium),
                  Text(
                    city,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
