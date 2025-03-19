import 'package:camera/camera.dart';

class CameraManager {
  CameraController? _cameraController;

  Future<List<CameraDescription>> getAvailableCameras() async {
    return await availableCameras();
  }

  Future<CameraController> initializeCamera(CameraDescription camera) async {
    _cameraController = CameraController(camera, ResolutionPreset.ultraHigh);
    await _cameraController!.initialize();
    return _cameraController!;
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