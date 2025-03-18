part of 'camera_bloc.dart';

@immutable
sealed class CameraState {
  final CameraManager cameraManager;

  const CameraState({required this.cameraManager});
}

final class CameraInitial extends CameraState {
  CameraInitial(): super(cameraManager: CameraManager());
}

final class CameraLoading extends CameraState {
  const CameraLoading({required super.cameraManager});
}

final class CameraLoaded extends CameraState {
  const CameraLoaded({required super.cameraManager});
}

final class CameraError extends CameraState {
  final String message;

  const CameraError(
    {
      required this.message,
      required super.cameraManager
    }
  );
}
