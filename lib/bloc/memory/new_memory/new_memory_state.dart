part of 'new_memory_bloc.dart';

@immutable
sealed class NewMemoryState {
  final String? memoryId;
  final String? creatorId;
  final String? description;
  final List<PendingMedia> mediaList;
  final EvaluationResultData? evaluationResultData;
  final PositionData? positionData;

  const NewMemoryState(
    {
      required this.memoryId,
      required this.creatorId,
      required this.description,
      required this.mediaList,
      required this.evaluationResultData,
      required this.positionData
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
      super.evaluationResultData,
      super.positionData
    }
  );

  NewMemoryInProgress copyWith(
    final String? newMemoryId,
    final String? newCreatorId,
    final String? newDescription,
    final List<PendingMedia>? newMediaList,
    final EvaluationResultData? newEvaluationResultData,
    final PositionData? newPositionData
  ) {
    return NewMemoryInProgress(
      memoryId: newMemoryId ?? memoryId,
      creatorId: newCreatorId ?? creatorId,
      description: newDescription ?? description,
      mediaList: newMediaList ?? mediaList,
      evaluationResultData: newEvaluationResultData ?? evaluationResultData,
      positionData: newPositionData ?? positionData
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
      required super.evaluationResultData,
      required super.positionData
    }
  );

  NewMemoryInProgress copyWith(
    final String? newMemoryId,
    final String? newCreatorId,
    final String? newDescription,
    final List<PendingMedia>? newMediaList,
    final EvaluationResultData? newEvaluationResultData,
    final PositionData? newPositionData
  ) {
    return NewMemoryInProgress(
      memoryId: newMemoryId ?? memoryId,
      creatorId: newCreatorId ?? creatorId,
      description: newDescription ?? description,
      mediaList: newMediaList ?? mediaList,
      evaluationResultData: newEvaluationResultData ?? evaluationResultData,
      positionData: newPositionData ?? positionData
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
      super.evaluationResultData,
      super.positionData
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
      super.evaluationResultData,
      this.errorMessage,
      super.positionData
    }
  );
}
