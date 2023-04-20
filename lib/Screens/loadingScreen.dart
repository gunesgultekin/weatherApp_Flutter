

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/Utils/_WeatherService.dart';

import '../Utils/_LocationService.dart';
import 'mainScreen.dart';


class loadingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => loadingScreenState();

}



class loadingScreenState extends State <loadingScreen>{

  late LocationService locationInfo;

  Future <void> getLocationInfo() async {

    locationInfo = LocationService();
    await locationInfo.getCurrentLocation();

    if(locationInfo.latitude == null ||
       locationInfo.longitude == null){
      print("Location Info cannot provided");
    }

    print("latitude: "+locationInfo.latitude.toString()
    +"\nlongitude: "+locationInfo.longitude.toString());

  }

  void getWeatherInfo() async {
    await getLocationInfo();
    WeatherService weatherInfo = WeatherService(locationInfo);
    await weatherInfo.getCurrentWeatherInfo();
    Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context){
      return mainScreen(weatherInfo: weatherInfo);
    }));
  }



  @override
  void initState() {
    getWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black12,Colors.black87,Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 200),
            Center(
              child: Container(
                child: Text(
                  "Getting Location Data...",
                  style: TextStyle(
                      letterSpacing: -0.55,
                      fontSize: 14.5,
                      color: Colors.white
                  ),
                ),
              ),
            ),

            SizedBox(height: 100),
            Center(
              child: SpinKitFadingFour(
                size: 80,
                color: Colors.white70,
              ),
            ),
          ],
        )
      ),
    );
  }
}