part of 'position_bloc.dart';

@immutable
sealed class PositionEvent {}

final class Init extends PositionEvent {}

final class GetPosition extends PositionEvent {}
