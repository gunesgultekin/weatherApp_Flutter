



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:weather_app/Utils/_LocationService.dart';
import 'package:weather_icons/weather_icons.dart';

const API_KEY= "921f7217e7be60e78bc53da68bb28609" ;


class WeatherDisplayService{
  late Icon weatherIcon;
  late AssetImage backgroundImage;
  WeatherDisplayService(@required this.weatherIcon,@required this.backgroundImage);

}



class WeatherService{

  late LocationService locationInfo;
  late double currentTemp;
  late String currentCondition;
  late int humidity;
  late double currentWind;
  late String currentCity;


  WeatherService(this.locationInfo);

  Future <void> getCurrentWeatherInfo() async {

    Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${locationInfo.latitude}"
        "&lon=${locationInfo.longitude}"
        "&appid=${API_KEY}&units=metric"));
    if(response.statusCode == 200){ // HTTP SUCCESS CODE
      String DATA = response.body;

      var currentWeatherInfo = jsonDecode(DATA);

      try{
        currentTemp = currentWeatherInfo["main"]["temp"];
        humidity = currentWeatherInfo["main"]["humidity"];
        currentCondition = currentWeatherInfo["weather"][0]["main"];
        currentWind = currentWeatherInfo["wind"]["speed"];
        currentCity = currentWeatherInfo["name"];


      }catch(e){
        print("Error while getting weather data");

      }
    }
    else{
      print("Weather API ERROR");
    }

}

WeatherDisplayService display(){
    if(currentCondition == "Clouds"){
      return WeatherDisplayService(Icon(WeatherIcons.day_cloudy), AssetImage("assets/sunny.jpg"));

    }

    else if(currentCondition == "Rain"){
      return WeatherDisplayService(Icon(WeatherIcons.raindrop), AssetImage("assets/rainy.jpg"));
    }

    else if(currentCondition == "Snow"){
      return WeatherDisplayService(Icon(WeatherIcons.snowflake_cold), AssetImage("assets/snowy.jpg"));
    }

    return WeatherDisplayService(Icon(WeatherIcons.sunrise), AssetImage("assets/sunnyjpg"));

}



}