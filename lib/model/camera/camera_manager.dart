import 'package:camera/camera.dart';
import 'package:roadsyouwalked_app/model/camera/camera_access_status.dart';

class CameraManager {
  CameraController? _cameraController;

  Future<List<CameraDescription>> getAvailableCameras() async {
    return await availableCameras();
  }

  Future<CameraAccessStatus> initializeCamera(CameraDescription camera) async {
    _cameraController = CameraController(camera, ResolutionPreset.ultraHigh);
    try {
      await _cameraController!.initialize();
      return CameraAccessGranted();
    } catch (error) {
      return CameraAccessDenied();
    }
  }

  void disposeCamera() {
    _cameraController?.dispose();
    _cameraController = null;
  }

  CameraController? getCameraController() {
    return _cameraController;
  }

  Future<XFile?> takePhoto() async {
    return await _cameraController?.takePicture();
  }
}
