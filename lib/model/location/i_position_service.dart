import 'package:roadsyouwalked_app/model/location/position_data.dart';

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
