part of 'position_bloc.dart';

@immutable
sealed class PositionState {
  final bool permissionGranted;
  final bool serviceEnabled;
  final PositionData? position;

  const PositionState({
    required this.permissionGranted,
    required this.serviceEnabled,
    required this.position,
  });
}

final class PositionInitial extends PositionState {
  const PositionInitial({
    super.permissionGranted = false,
    super.serviceEnabled = false,
    super.position,
  });
}

final class PositionLoaded extends PositionState {
  const PositionLoaded({
    required super.permissionGranted,
    required super.serviceEnabled,
    required super.position,
  });
}

final class PositionDenied extends PositionState {
  const PositionDenied({
    required super.permissionGranted,
    required super.serviceEnabled,
    super.position,
  });
}

final class PositionDisabled extends PositionState {
  const PositionDisabled({
    required super.permissionGranted,
    required super.serviceEnabled,
    super.position,
  });
}
