import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../managers/api/api_key.dart';
import '../managers/api/fetch_weather.dart';
import 'package:http/http.dart' as http;

import '../model/search_data_model.dart';
import '../model/weather_data.dart';

class GlobalController extends GetxController   {
  var searchController = TextEditingController().obs;
  var getSearchjsonData = SearchLocationModel(
          weather: List<Weather>.empty(growable: true), coord: Coord(), 
         
          )
      .obs;
  // var searchDataEntity =
  //    SearchLocationModel().obs;

  // Create various variables
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _cardIndex = 0.obs;

  final searchActive = false.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() async {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }

    super.onInit();
  }

  Future<void> getSearchData() async {
    http.Response response;
    try {
      // response = await http.get(
      //   Uri.parse(

      //       // "https://api.openweathermap.org/data/2.5/weather?q=${searchController.value.text}&appid=$apiKey"
            // "https://api.openweathermap.org/data/2.5/weather?q=${searchController.value.text}&appid=$apiKey&units=metric"),
           
            
      //   headers: {
      //     'content-Type': 'application/json',
      //   },
   
      // );
      var url=Uri.http('api.openweathermap.org', 'data/2.5/weather', {'q': searchController.value.text,
      'appid':apiKey,'units':'metric'
      });
      print("=======$url=========");
      response=  await http.get( url ) ;

      if (response.statusCode == 200) {
        print("api cal  success");

        getSearchjsonData.value =
            SearchLocationModel.fromJson(jsonDecode(response.body));
        searchActive.value = true;
        print("24424242466${getSearchjsonData.toJson()}");
      } else {
        print("api call failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // Return if service is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    // static of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    // getting the currentposition
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      // Updating the latitude and longitude
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      // Calling Weather API
      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _cardIndex;
  }
}
