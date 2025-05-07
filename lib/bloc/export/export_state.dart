part of 'export_bloc.dart';

@immutable
sealed class ExportState {}

final class ExportInitial extends ExportState {}

final class ExportingEvaluations extends ExportState {}

final class EvaluationsExported extends ExportState {
  final String message;

  EvaluationsExported({required this.message});
}

final class ExportFailed extends ExportState {
  final String message;

  ExportFailed({required this.message});
}
