import 'package:flutter/services.dart';
import 'package:location/location.dart';

class GPSUtil {

  var _location = Location();


  Future<bool> isPermissionGPS() {
    return _location.serviceEnabled();
  }

  Future<bool> requestPermissionGPS() {
   return _location.requestPermission();
  }

  Future<LocationData> getLastLocation() async {

    var isPermited = await isPermissionGPS();

    if(isPermited){
      return await _location.getLocation();
    }

    var isOK = await requestPermissionGPS();
    if(isOK) getLastLocation(); else return null;

  }


  void onLocationChanged(Function(LocationData) onData) {
    _location.onLocationChanged().listen(onData);
  }

  Future<bool> changeDefaultSettings(
      {LocationAccuracy accuracy,
      int interval,
    double distanceFilter}) async {
    return _location.changeSettings(accuracy: accuracy, interval: interval, distanceFilter: distanceFilter);
  }


}