part of 'memories_detail_bloc.dart';

@immutable
sealed class MemoriesDetailState {
  final List<Memory> memories;

  const MemoriesDetailState({required this.memories});
}

final class MemoriesDetailInitial extends MemoriesDetailState {
  const MemoriesDetailInitial(
    {
      super.memories = const []
    }
  );
}

final class MemoriesDetailLoaded extends MemoriesDetailState {
  const MemoriesDetailLoaded(
    {
      required super.memories
    }
  );
}
