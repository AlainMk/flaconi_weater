import 'package:flaconi_weather/theme/border_radius.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WeatherInfoContainer extends StatelessWidget {
  const WeatherInfoContainer({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FlaconiSpacing.largeXxl,
        vertical: FlaconiSpacing.medium,
      ),
      decoration: BoxDecoration(
        color: FlaconiColors.white,
        borderRadius: BorderRadius.circular(FlaconiBorderRadius.huge),
        boxShadow: [
          BoxShadow(
            color: FlaconiColors.border.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon),
          const Gap(FlaconiSpacing.small),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
