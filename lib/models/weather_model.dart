class WeatherModel {
  final String city;
  final String date;
  final String weather;
  final String imgCode;
  final double temp;
  final double maxTemp;
  final double minTemp;

  WeatherModel(
      {required this.city,
      required this.date,
      required this.weather,
      required this.imgCode,
      required this.temp,
      required this.maxTemp,
      required this.minTemp});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        city: json['city'],
        date: json['applicable_date'],
        weather: json['weather_state_name'],
        imgCode: json['weather_state_abbr'],
        temp: json['the_temp'],
        maxTemp: json['max_temp'],
        minTemp: json['min_temp']);
  }
}
