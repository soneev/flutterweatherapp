

import '../managers/api/api_key.dart';

String apiUrl(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$apiKey&units=metric";
  return url;
}

String searchUrl(var q){
    String searchUrl;
searchUrl="https://api.openweathermap.org/data/2.5/weather?q=$q&appid=$apiKey&units=metric";

// searchUrl="https://api.openweathermap.org/data/2.5/weather?q=$q&appid=$apiKey";
return searchUrl;
}