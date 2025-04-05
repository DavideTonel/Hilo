part of 'memory_bloc.dart';

@immutable
sealed class MemoryEvent {}

final class LoadMemoriesByUserId extends MemoryEvent {
  final String userId;

  LoadMemoriesByUserId({required this.userId});
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
