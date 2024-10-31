import 'package:flaconi_weather/theme/border_radius.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WeatherCityContainer extends StatefulWidget {
  const WeatherCityContainer({
    super.key,
    required this.city,
    required this.onTap,
  });

  final String city;
  final Function(String) onTap;

  @override
  State<WeatherCityContainer> createState() => _WeatherCityContainerState();
}

class _WeatherCityContainerState extends State<WeatherCityContainer> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.large, vertical: FlaconiSpacing.smallMedium),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Search City',
                    hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: FlaconiColors.lightGray),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: FlaconiColors.darkerText,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.largeXl),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(FlaconiBorderRadius.huge),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: FlaconiColors.background,
                    filled: true,
                  ),
                ),
              ),
              const Gap(FlaconiSpacing.medium),
              FlaconiCircleButton(
                onPressed: () {
                  widget.onTap(_controller.text);
                },
                icon: Icons.search,
              )
            ],
          ),
        ),
        const Gap(FlaconiSpacing.normal),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_city,
              color: FlaconiColors.secondary,
            ),
            const Gap(FlaconiSpacing.smallMedium),
            Text(
              widget.city,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: FlaconiColors.secondary),
            ),
          ],
        ),
      ],
    );
  }
}
