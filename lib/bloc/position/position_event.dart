part of 'position_bloc.dart';

@immutable
sealed class PositionEvent {}

final class Initialize extends PositionEvent {}

final class GetLocation extends PositionEvent {}
