part of 'new_memory_bloc.dart';

@immutable
sealed class NewMemoryState {
  final String? memoryId;
  final String? creatorId;
  final String? description;
  final List<PendingMedia> mediaList;

  const NewMemoryState(
    {
      required this.memoryId,
      required this.creatorId,
      required this.description,
      required this.mediaList
    }
  );
}

final class NewMemoryInitial extends NewMemoryState {
  const NewMemoryInitial(
    {
      super.memoryId,
      super.creatorId,
      super.description,
      super.mediaList = const []
    }
  );

  NewMemoryInProgress copyWith(
    final String? newMemoryId,
    final String? newCreatorId,
    final String? newDescription,
    final List<PendingMedia>? newMediaList
  ) {
    return NewMemoryInProgress(
      memoryId: newMemoryId ?? memoryId,
      creatorId: newCreatorId ?? creatorId,
      description: newDescription ?? description,
      mediaList: newMediaList ?? mediaList
    );
  }
}

final class NewMemoryInProgress extends NewMemoryState {
  const NewMemoryInProgress(
    {
      required super.memoryId,
      required super.creatorId,
      required super.description,
      required super.mediaList
    }
  );

  NewMemoryInProgress copyWith(
    final String? newMemoryId,
    final String? newCreatorId,
    final String? newDescription,
    final List<PendingMedia>? newMediaList
  ) {
    return NewMemoryInProgress(
      memoryId: newMemoryId ?? memoryId,
      creatorId: newCreatorId ?? creatorId,
      description: newDescription ?? description,
      mediaList: newMediaList ?? mediaList
    );
  }
}

final class NewMemorySaveSuccess extends NewMemoryState {
  const NewMemorySaveSuccess(
    {
      super.memoryId,
      super.creatorId,
      super.description,
      super.mediaList = const []
    }
  );
}

final class NewMemorySaveFailure extends NewMemoryState {
  const NewMemorySaveFailure(
    {
      super.memoryId,
      super.creatorId,
      super.description,
      super.mediaList = const []
    }
  );
}
