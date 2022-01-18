import 'package:geolocator/geolocator.dart';

class Location {
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
  }
}
