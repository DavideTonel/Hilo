import 'package:roadsyouwalked_app/model/location/position_data.dart';

/// An interface for accessing and managing device location services.
///
/// This interface defines the contract for any service that provides
/// access to the current position of the device, including permission handling
/// and service availability.
///
/// Implementing classes should ensure that `ensureReady()` handles
/// both permission and service checks before accessing location.
///
/// Methods:
/// - [requestPermission]: Asks the user for location permission.
/// - [enableService]: Attempts to enable location services (e.g., GPS).
/// - [hasPermission]: Checks whether location permission is granted.
/// - [isServiceEnabled]: Checks whether location services are enabled.
/// - [ensureReady]: Ensures both permission and service are ready for use.
/// - [getCurrentPosition]: Returns the current position of the device.
///
/// Properties:
/// - [permissionGranted]: Whether location permission has been granted.
/// - [serviceEnabled]: Whether location services are currently enabled.
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
