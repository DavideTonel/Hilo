import 'package:location/location.dart';

class LocationManager {
  final Location _location = Location();

  Future<bool> init() async {
    PermissionStatus status = await _location.hasPermission();
    if (status == PermissionStatus.granted || status == PermissionStatus.grantedLimited) {
      return true;
    } else {
      status = await _location.requestPermission();
      if (status == PermissionStatus.granted || status == PermissionStatus.grantedLimited) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> isGranted() async {
    final status = await _location.hasPermission();
    return status == PermissionStatus.granted || status == PermissionStatus.grantedLimited;
  }

  Future<bool> isServiceEnabled() async {
    return await _location.serviceEnabled();
  }

  Future<bool> requestService() async {
    return await _location.requestService();
  }

  Future<LocationData> getLocation() async {
    await _location.changeSettings(
      accuracy: LocationAccuracy.high
    );
    return await _location.getLocation();
  }
}
