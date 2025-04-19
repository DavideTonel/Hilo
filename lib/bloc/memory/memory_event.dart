part of 'memory_bloc.dart';

@immutable
sealed class MemoryEvent {}

final class LoadMemories extends MemoryEvent {
  final String userId;
  final MemoryOrderType orderType;
  final int? year;
  final int? month;
  final int? nLastDays;

  LoadMemories(
    {
      required this.userId,
      required this.orderType,
      this.year,
      this.month,
      this.nLastDays
    }
  );
}

final class SetTime extends MemoryEvent {
  final String userId;
  final int? year;
  final int? month;

  SetTime(
    {
      required this.userId,
      this.year,
      this.month
    }
  );
}
