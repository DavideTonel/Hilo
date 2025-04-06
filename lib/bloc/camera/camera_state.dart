part of 'camera_bloc.dart';

@immutable
sealed class CameraState {
  final CameraManager cameraManager;
  final XFile? photoTaken;

  const CameraState(
    {
      required this.cameraManager,
      this.photoTaken
    }
  );
}

final class CameraInitial extends CameraState {
  CameraInitial(): super(cameraManager: CameraManager());
}

final class CameraLoaded extends CameraState {
  const CameraLoaded({required super.cameraManager});
}

final class CameraMediaTaken extends CameraState {
  const CameraMediaTaken(
    {
      required super.cameraManager,
      required super.photoTaken
    }
  );
}

final class CameraMediaAccepted extends CameraState {
  const CameraMediaAccepted(
    {
      required super.cameraManager,
      required super.photoTaken
    }
  );
}

final class CameraDenied extends CameraState {
  const CameraDenied(
    {
      required super.cameraManager
    }
  );
}
