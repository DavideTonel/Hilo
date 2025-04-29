part of 'camera_bloc.dart';

@immutable
sealed class CameraEvent {}

final class InitCamera extends CameraEvent {}

final class DisposeCamera extends CameraEvent {}

final class TakePhoto extends CameraEvent {}

final class DiscardMedia extends CameraEvent {}

final class AcceptMedia extends CameraEvent {}
