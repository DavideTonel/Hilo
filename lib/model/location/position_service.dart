import 'package:location/location.dart';
import 'package:roadsyouwalked_app/model/location/i_position_service.dart';
import 'package:roadsyouwalked_app/model/location/position_data.dart';

/// A concrete implementation of [IPositionService].
///
/// This service handles location permission requests, service enablement,
/// and provides access to the device’s current geographic position.
///
/// Example usage:
/// ```dart
/// final positionService = PositionService();
/// await positionService.ensureReady();
/// final position = await positionService.getCurrentPosition();
/// ```
class PositionService extends IPositionService {
  final Location _location = Location();

  bool _permissionGranted = false;
  bool _serviceEnabled = false;

  /// Returns whether location permission has been granted.
  @override
  bool get permissionGranted => _permissionGranted;

  /// Returns whether the location service is enabled.
  @override
  bool get serviceEnabled => _serviceEnabled;

  /// Ensures both permission and service are enabled before using location features.
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

  /// Returns the current [PositionData] if both permission and service are granted/enabled.
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

  /// Requests location permission from the user.
  @override
  Future<bool> requestPermission() async {
    await _location.requestPermission();
    return _permissionGranted = await hasPermission();
  }

  /// Checks whether location permission is already granted.
  @override
  Future<bool> hasPermission() async {
    final status = await _location.hasPermission();
    _permissionGranted = status == PermissionStatus.granted || status == PermissionStatus.grantedLimited;
    return _permissionGranted;
  }

  /// Prompts the user to enable the location service.
  @override
  Future<bool> enableService() async {
    _serviceEnabled = await _location.requestService();
    return _serviceEnabled;
  }

  /// Checks if the location service is currently enabled.
  @override
  Future<bool> isServiceEnabled() async {
    _serviceEnabled = await _location.serviceEnabled();
    return _serviceEnabled;
  }
}
