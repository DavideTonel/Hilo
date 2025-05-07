import 'package:camera/camera.dart';
import 'package:roadsyouwalked_app/model/camera/camera_access_status.dart';

/// Manages camera-related operations, including initialization, disposal,
/// access status checking, and capturing photos.
///
/// This class acts as a wrapper around the `camera` plugin to simplify
/// camera usage within the application. It handles permission errors and 
/// maintains an internal `CameraController`.
class CameraManager {
  CameraController? _cameraController;

  /// Returns a list of available cameras on the device.
  ///
  /// Typically called once during app startup to allow the user to select
  /// a preferred camera (e.g., front or rear).
  Future<List<CameraDescription>> getAvailableCameras() async {
    return await availableCameras();
  }

  /// Initializes the camera with the given [camera] description.
  ///
  /// Returns [CameraAccessStatus.granted] if initialization succeeds,
  /// otherwise [CameraAccessStatus.denied].
  Future<CameraAccessStatus> initializeCamera(CameraDescription camera) async {
    _cameraController = CameraController(camera, ResolutionPreset.ultraHigh);
    try {
      await _cameraController!.initialize();
      return CameraAccessStatus.granted;
    } catch (error) {
      return CameraAccessStatus.denied;
    }
  }

  /// Disposes the current camera controller, releasing all resources.
  ///
  /// Should be called when the camera is no longer needed, typically
  /// in the `dispose()` method of a widget or on page exit.
  void disposeCamera() {
    _cameraController?.dispose();
    _cameraController = null;
  }

  /// Returns the current [CameraController] instance, if initialized.
  ///
  /// May return null if the camera has not been initialized or has
  /// been disposed.
  CameraController? getCameraController() {
    return _cameraController;
  }

  /// Captures a photo using the active camera and returns the image file.
  ///
  /// Returns `null` if the camera controller is not available or not initialized.
  Future<XFile?> takePhoto() async {
    return await _cameraController?.takePicture();
  }
}
