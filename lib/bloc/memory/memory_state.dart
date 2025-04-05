part of 'memory_bloc.dart';

@immutable
sealed class MemoryState {
  final List<Memory> memories;


  const MemoryState({required this.memories});
}

final class MemoryInitial extends MemoryState {
  const MemoryInitial(
    {
      super.memories = const [],
    }
  );
}

final class MemoriesLoaded extends MemoryState {
  const MemoriesLoaded(
    {
      required super.memories,
    }
  );
} 
