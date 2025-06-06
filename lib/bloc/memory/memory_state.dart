part of 'memory_bloc.dart';

@immutable
sealed class MemoryState {
  final List<Memory> memories;
  final MemoryOrderType orderType;
  final int year;
  final int month;
  final int lastNDays;


  const MemoryState(
    {
      required this.memories,
      required this.orderType,
      required this.year,
      required this.month,
      required this.lastNDays
    }
  );
}

final class MemoryInitial extends MemoryState {
  const MemoryInitial(
    {
      super.memories = const [],
      super.orderType = MemoryOrderType.timeline,
      required super.year,
      required super.month,
      required super.lastNDays
    }
  );
}

final class MemoriesLoaded extends MemoryState {
  const MemoriesLoaded(
    {
      required super.memories,
      required super.orderType,
      required super.year,
      required super.month,
      required super.lastNDays
    }
  );
} 
