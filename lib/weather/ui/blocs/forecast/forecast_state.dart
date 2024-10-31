part of 'forecast_bloc.dart';

sealed class ForecastState extends Equatable {
  const ForecastState();
}

final class ForecastInitial extends ForecastState {
  @override
  List<Object> get props => [];
}
