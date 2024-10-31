import 'package:flaconi_weather/theme/border_radius.dart';
import 'package:flaconi_weather/theme/colors.dart';
import 'package:flaconi_weather/theme/spacing.dart';
import 'package:flaconi_weather/theme/utils.dart';
import 'package:flaconi_weather/weather/ui/bloc/forecast_bloc.dart';
import 'package:flaconi_weather/weather/ui/error_screen.dart';
import 'package:flaconi_weather/weather/ui/forecast_list.dart';
import 'package:flaconi_weather/weather/ui/weather_success.dart';
import 'package:flaconi_weather/widgets/circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForecastBloc()..add(const GetForecastByLocation()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlaconiCircleButton(
                    onPressed: () {
                      final units = context.read<ForecastBloc>().state is SuccessForecastState
                          ? (context.read<ForecastBloc>().state as SuccessForecastState).units
                          : WeatherUnit.metric;
                      context.read<ForecastBloc>().add(GetForecastByLocation(units: units));
                    },
                    icon: CupertinoIcons.location_fill,
                  ),
                  const Spacer(),
                  const Icon(Icons.cloud),
                  const SizedBox(width: FlaconiSpacing.smallMedium),
                  const Text('Weather'),
                  const Spacer(),
                  FlaconiCircleButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          final units = context.read<ForecastBloc>().state is SuccessForecastState
                              ? (context.read<ForecastBloc>().state as SuccessForecastState).units
                              : WeatherUnit.metric;
                          return EditUnitsWidget(
                            selectedUnit: units,
                            onUnitSelected: (unit) {
                              context.read<ForecastBloc>().add(ChangeUnits(unit));
                            },
                          );
                        },
                      );
                    },
                    icon: Icons.more_vert,
                  ),
                ],
              ),
            ),
            body: BlocConsumer<ForecastBloc, ForecastState>(
              listener: (context, state) {
                if (state is ErrorForecastState) {
                  showErrorSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is LoadingForecastState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorForecastState) {
                  return WeatherErrorScreen(message: state.message);
                }

                final weatherState = state as SuccessForecastState;
                return RefreshIndicator(
                  onRefresh: () async {
                    if (weatherState.cityName == null) {
                      context.read<ForecastBloc>().add(GetForecastByLocation(units: weatherState.units));
                    } else {
                      context.read<ForecastBloc>().add(GetForecastByCity(weatherState.cityName!, units: weatherState.units));
                    }
                  },
                  child: ListView(
                    children: [
                      SuccessWeatherContainer(state: weatherState),
                      const Gap(FlaconiSpacing.largeXl),
                      const ForecastListContent(),
                      const Gap(FlaconiSpacing.largeXl),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class EditUnitsWidget extends StatefulWidget {
  const EditUnitsWidget({
    super.key,
    required this.onUnitSelected,
    this.selectedUnit = WeatherUnit.metric,
  });

  final Function(WeatherUnit) onUnitSelected;
  final WeatherUnit selectedUnit;

  @override
  State<EditUnitsWidget> createState() => _EditUnitsWidgetState();
}

class _EditUnitsWidgetState extends State<EditUnitsWidget> {
  WeatherUnit _selectedUnit = WeatherUnit.metric;

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.selectedUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(FlaconiSpacing.large),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(FlaconiSpacing.large),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = WeatherUnit.metric;
                    });
                  },
                  child: _buildSelector(context, 'Metric', isSelected: _selectedUnit == WeatherUnit.metric),
                ),
              ),
              const Gap(FlaconiSpacing.large),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedUnit = WeatherUnit.imperial;
                    });
                  },
                  child: _buildSelector(context, 'Imperial', isSelected: _selectedUnit == WeatherUnit.imperial),
                ),
              ),
            ],
          ),
          const Gap(FlaconiSpacing.medium),
          FlaconiCircleButton(
            onPressed: () {
              widget.onUnitSelected(_selectedUnit);
              Navigator.pop(context);
            },
            icon: Icons.check,
            size: 60,
          ),
          const Gap(FlaconiSpacing.medium),
        ],
      ),
    );
  }

  Widget _buildSelector(BuildContext context, String units, {bool isSelected = false}) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(FlaconiSpacing.medium),
      decoration: BoxDecoration(
        color: isSelected ? FlaconiColors.primary : FlaconiColors.border.withOpacity(0.8),
        borderRadius: BorderRadius.circular(FlaconiBorderRadius.huge),
      ),
      child: Text(
        units,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: isSelected ? FlaconiColors.white : null),
      ),
    );
  }
}
