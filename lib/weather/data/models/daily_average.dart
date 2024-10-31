class DailyAverage {
  final DateTime date;
  final double minTemperature;
  final double maxTemperature;
  final double temperature;
  final String icon;
  final String weatherCondition;
  final double windSpeed;
  final double pressure;
  final double humidity;

  DailyAverage({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.temperature,
    required this.icon,
    required this.weatherCondition,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
  });
}
