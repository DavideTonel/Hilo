part of 'memory_bloc.dart';

@immutable
sealed class MemoryEvent {}

final class LoadMemoriesByUserId extends MemoryEvent {
  final String userId;
  final MemoryOrderType orderType;
  final int? year;
  final int? month;

  LoadMemoriesByUserId(
    {
      required this.userId,
      required this.orderType,
      this.year,
      this.month
    }
  );
}

final class SaveMemory extends MemoryEvent {
  final String creatorId;
  final MediaType type;
  final File file;

  SaveMemory(
    {
      required this.creatorId,
      required this.type,
      required this.file
    }
  );
}
