part of 'export_bloc.dart';

@immutable
sealed class ExportEvent {}

final class Export extends ExportEvent {
  final String userId;
  final int lastNDays;

  Export({required this.userId, required this.lastNDays});
}
