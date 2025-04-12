part of 'new_memory_bloc.dart';

@immutable
sealed class NewMemoryState {
  final String? memoryId;
  final String? creatorId;
  final String? description;
  final List<PendingMedia> mediaList;
  final MoodEvaluationScoreData? moodEvaluationScore;

  const NewMemoryState(
    {
      required this.memoryId,
      required this.creatorId,
      required this.description,
      required this.mediaList,
      required this.moodEvaluationScore
    }
  );
}

final class NewMemoryInitial extends NewMemoryState {
  const NewMemoryInitial(
    {
      super.memoryId,
      super.creatorId,
      super.description,
      super.mediaList = const [],
      super.moodEvaluationScore
    }
  );

  NewMemoryInProgress copyWith(
    final String? newMemoryId,
    final String? newCreatorId,
    final String? newDescription,
    final List<PendingMedia>? newMediaList,
    final MoodEvaluationScoreData? newMoodEvaluationScore
  ) {
    return NewMemoryInProgress(
      memoryId: newMemoryId ?? memoryId,
      creatorId: newCreatorId ?? creatorId,
      description: newDescription ?? description,
      mediaList: newMediaList ?? mediaList,
      moodEvaluationScore: newMoodEvaluationScore ?? moodEvaluationScore
    );
  }
}

final class NewMemoryInProgress extends NewMemoryState {
  const NewMemoryInProgress(
    {
      required super.memoryId,
      required super.creatorId,
      required super.description,
      required super.mediaList,
      required super.moodEvaluationScore
    }
  );

  NewMemoryInProgress copyWith(
    final String? newMemoryId,
    final String? newCreatorId,
    final String? newDescription,
    final List<PendingMedia>? newMediaList,
    final MoodEvaluationScoreData? newMoodEvaluationScore
  ) {
    return NewMemoryInProgress(
      memoryId: newMemoryId ?? memoryId,
      creatorId: newCreatorId ?? creatorId,
      description: newDescription ?? description,
      mediaList: newMediaList ?? mediaList,
      moodEvaluationScore: newMoodEvaluationScore ?? moodEvaluationScore
    );
  }
}

final class NewMemorySaveSuccess extends NewMemoryState {
  const NewMemorySaveSuccess(
    {
      super.memoryId,
      super.creatorId,
      super.description,
      super.mediaList = const [],
      super.moodEvaluationScore
    }
  );
}

final class NewMemorySaveFailure extends NewMemoryState {
  final String? errorMessage;
  
  const NewMemorySaveFailure(
    {
      super.memoryId,
      super.creatorId,
      super.description,
      super.mediaList = const [],
      super.moodEvaluationScore,
      this.errorMessage
    }
  );
}
