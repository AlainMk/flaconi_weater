import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaconi_weather/theme/border_radius.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/weather/ui/bloc/forecast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForecastListContent extends StatelessWidget {
  const ForecastListContent({
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

        final forecastState = state as SuccessForecastState;
        final forecastItems = state.forecastItems;
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
            const Gap(FlaconiSpacing.largeL),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastItems.length,
                padding: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.large),
                itemBuilder: (context, index) {
                  return ItemForecastWidget(
                    item: forecastItems[index],
                    isSelected: forecastState.selectedForecastDetails.date.isAtSameMomentAs(forecastItems[index].date),
                    onTap: () {
                      context.read<ForecastBloc>().add(SelectForecastItem(forecastItems[index].dailyForecast));
                    },
                  );
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
    required this.onTap,
    this.isSelected = false,
  });

  final ForecastItem item;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: FlaconiSpacing.small),
      decoration: BoxDecoration(
        color: isSelected ? FlaconiColors.primary.withOpacity(0.4) : FlaconiColors.background,
        borderRadius: BorderRadius.circular(FlaconiBorderRadius.huge),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(FlaconiBorderRadius.huge),
          child: Container(
            padding: const EdgeInsets.all(FlaconiSpacing.medium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.convertedDate,
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
          ),
        ),
      ),
    );
  }
}
