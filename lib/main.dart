
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Screens/loadingScreen.dart';

import 'Screens/mainScreen.dart';



void main(){
  runApp(app());
}

class app extends StatelessWidget{
  const app({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: loadingScreen()

    );


  }
  
}

