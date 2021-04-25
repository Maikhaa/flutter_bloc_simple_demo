class WeatherModel {
  final String date;
  final String weather;
  final double temp;
  final double maxTemp;
  final double minTemp;

  WeatherModel(
      {required this.date,
      required this.weather,
      required this.temp,
      required this.maxTemp,
      required this.minTemp});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        date: json['applicable_date'],
        weather: json['weather_state_name'],
        temp: json['the_temp'],
        maxTemp: json['max_temp'],
        minTemp: json['min_temp']);
  }
}
