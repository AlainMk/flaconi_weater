import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi_weather/theme/border_radius.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/weather/ui/blocs/forecast/forecast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NextForecastContent extends StatelessWidget {
  const NextForecastContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(
      builder: (context, state) {
        if (state is LoadingForecastState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorForecastState) {
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.large),
              child: Text(state.message),
            ),
          );
        }

        final forecastItems = (state as SuccessForecastState).forecastItems;
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.large),
              alignment: Alignment.centerLeft,
              child: Text(
                '${forecastItems.length} Days Forecast',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Gap(FlaconiSpacing.largeXl),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastItems.length,
                padding: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.large),
                itemBuilder: (context, index) {
                  return ItemForecastWidget(item: forecastItems[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class ItemForecastWidget extends StatelessWidget {
  const ItemForecastWidget({
    super.key,
    required this.item,
  });

  final ForecastItem item;

  @override
  Widget build(BuildContext context) {
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
            item.date,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Expanded(
            child: CachedNetworkImage(
              imageUrl: item.icon,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            item.temperature,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
