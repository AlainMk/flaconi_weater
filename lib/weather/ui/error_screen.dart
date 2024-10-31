import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/weather/ui/bloc/forecast_bloc.dart';
import 'package:flaconi_weather/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
                context.read<ForecastBloc>().add(const GetForecastByLocation());
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
