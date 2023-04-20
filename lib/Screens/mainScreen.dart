import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:weather_app/Utils/_WeatherService.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/Utils/_WeatherService.dart';



class mainScreen extends StatefulWidget{

  final WeatherService weatherInfo;

  mainScreen({required this.weatherInfo});

  @override
  State<StatefulWidget> createState() => _mainScreenState();

}

class _mainScreenState extends State <mainScreen>{

  late AssetImage backgroundImage;
  late Icon currentWeatherIcon;
  late int currentTemp;
  late String currentStatus;
  late int currentHumidity;
  late double currentWind;
  late String currentCity;


  void updateDisplayInfo(WeatherService weatherService){
    setState(() {
      currentTemp = weatherService.currentTemp.round();
      WeatherDisplayService weatherDisplayService = weatherService.display();
      backgroundImage = weatherDisplayService.backgroundImage;
      currentWeatherIcon = weatherDisplayService.weatherIcon;
      currentStatus = weatherService.currentCondition.toString();
      currentHumidity = weatherService.humidity;
      currentWind = weatherService.currentWind;
      currentCity = weatherService.currentCity;
    });
  }

  @override
  void initState() {
    updateDisplayInfo(widget.weatherInfo);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 125),
            Container(
              child: currentWeatherIcon,
            ),

            SizedBox(height: 25),
            Center(
              child: Text(
                " ${currentTemp}°",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 75,
                  letterSpacing: -2,
                ),
              ),
            ),

            SizedBox(height: 5),
            Center(
              child: Text(
                "$currentStatus",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.5,
                  letterSpacing: -0.55
                ),
              ),
            ),

            SizedBox(height: 15),
            Center(
              child: Text(
                "Humidity: ${currentHumidity}%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  letterSpacing: -0.55,
                ),
              ),
            ),

            SizedBox(height: 15),
            Center(
              child: Text(
                "Wind: ${currentWind} km/h",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
                  letterSpacing: -0.5,
                ),
              ),
            ),


            SizedBox(height: 40),
            Center(
              child: Text(
                "${currentCity}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    letterSpacing: -0.55
                ),
              ),
            ),

            SizedBox(height: 17.5),
            Center(
              child: DigitalClock(
                is24HourTimeFormat: true,
                showSecondsDigit: false,
                hourMinuteDigitTextStyle: TextStyle(
                  fontSize: 20,
                  letterSpacing: -1
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}