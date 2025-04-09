import 'package:location/location.dart';

abstract class IPositionService {
  Future<bool> requestPermission();
  Future<bool> enableService();
  Future<bool> hasPermission();
  Future<bool> isServiceEnabled();
  Future<void> ensureReady();
  Future<PositionData?> getCurrentPosition();

  bool get permissionGranted;
  bool get serviceEnabled;
}


class PositionData {
  final double latitude;
  final double longitude;

  PositionData({required this.latitude, required this.longitude});
}

class PositionService extends IPositionService {
  final Location _location = Location();

  bool _permissionGranted = false;
  bool _serviceEnabled = false;

  @override
  bool get permissionGranted => _permissionGranted;

  @override
  bool get serviceEnabled => _serviceEnabled;

  @override
  Future<void> ensureReady() async {
    _permissionGranted = await hasPermission();
    if (!_permissionGranted) {
      _permissionGranted = await requestPermission();
    }

    _serviceEnabled = await isServiceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await enableService();
    }
  }

  @override
  Future<PositionData?> getCurrentPosition() async {
    _permissionGranted = await hasPermission();
    _serviceEnabled = await isServiceEnabled();

    if (_permissionGranted && _serviceEnabled) {
      final data = await _location.getLocation();
      if (data.latitude != null && data.longitude != null) {
        return PositionData(
          latitude: data.latitude!,
          longitude: data.longitude!,
        );
      }
    }
    return null;
  }

  @override
  Future<bool> requestPermission() async {
    await _location.requestPermission();
    return _permissionGranted = await hasPermission();
  }

  @override
  Future<bool> hasPermission() async {
    final status = await _location.hasPermission();
    _permissionGranted = status == PermissionStatus.granted || status == PermissionStatus.grantedLimited;
    return _permissionGranted;
  }

  @override
  Future<bool> enableService() async {
    _serviceEnabled = await _location.requestService();
    return _serviceEnabled;
  }

  @override
  Future<bool> isServiceEnabled() async {
    _serviceEnabled = await _location.serviceEnabled();
    return _serviceEnabled;
  }
}
