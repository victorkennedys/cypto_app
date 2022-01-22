import 'package:geolocator/geolocator.dart';

class LocationModel {
  Future<Map<String, dynamic>?> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        Map<String, dynamic> locationData = {
          'longitude': position.longitude,
          'latitude': position.latitude,
        };
        return locationData;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
