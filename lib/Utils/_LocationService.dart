


import 'dart:html';

import 'package:location/location.dart';

class LocationService{

  late double latitude;
  late double longitude;

  Future <void> getCurrentLocation() async {

    Location location= Location();
    LocationData locationData;

    if( await location.serviceEnabled() == false ){ // if service is unavailable
      await location.requestService(); // try to request service again
      if( await location.serviceEnabled() == false ){ // re-request for service failed
        return;
      }
    }

    if( await location.hasPermission() == PermissionStatus.denied ){ // if no permission
      await location.requestPermission(); // re-request permission
      if( await location.hasPermission() == false){ // if re-request for permission failed
        return;
      }
    }

    // IF SERVICE IS ENABLED AND PERMISSION GRANTED

    locationData = await location.getLocation();
    latitude = locationData.latitude!;
    longitude = locationData.longitude!;
  }
}