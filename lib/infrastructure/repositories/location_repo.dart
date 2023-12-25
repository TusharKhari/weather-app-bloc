import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationRepo {

  //  check permission of location and getting the permission

  Future<Position?> checkPermission() async {
    Position? position;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    await Geolocator.requestPermission();
    if (serviceEnabled) {
      position = await _getCurrentLocation();
    } else {
      openAppSettings();
    }
    return position;
  }

// if permission then get the lat and lng
  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
