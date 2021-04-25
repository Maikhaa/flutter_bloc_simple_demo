// Api calls
const String kstBaseUrl = 'www.metaweather.com';
const String kstLocationPath = '/api/location/search/';

// Testing
const String KstFakeLocationResponseString =
    '[{"title":"London","location_type":"City","woeid":44418,"latt_long":"51.506321,-0.12714"}]';
const String KstFakeWeatherResponseString =
    '{"consolidated_weather":[{"id":6155851753586688,"weather_state_name":"Heavy Cloud","weather_state_abbr":"hc","wind_direction_compass":"ENE","created":"2021-04-21T09:31:03.174212Z","applicable_date":"2021-04-21","min_temp":5.84,"max_temp":13.81,"the_temp":13.72,"wind_speed":7.375899323969352,"wind_direction":58.490704253588966,"air_pressure":1021.5,"humidity":60,"visibility":9.479949594368886,"predictability":71}]}';

// UI
const double kstSmallPadding = 15.0;
const double kstRegularPadding = 40.0;
const double kstLargePadding = 60.0;

const double kstSmallBox = 30.0;
const double kstRegularBox = 60.0;
const double kstLargeBox = 160.0;
