part of 'new_memory_bloc.dart';

@immutable
sealed class NewMemoryEvent {}

final class InitNewMemory extends NewMemoryEvent {
  final String creatorId;

  InitNewMemory({required this.creatorId});
}

final class AddMedia extends NewMemoryEvent {
  final File? localFile;
  final String? remoteUri;
  final MediaType mediaType;

  AddMedia(
    {
      required this.localFile,
      required this.remoteUri,
      required this.mediaType
    }
  );
}

final class AddMoodEvaluation extends NewMemoryEvent {
  final EvaluationResultData evaluationResultData;

  AddMoodEvaluation({required this.evaluationResultData});
}

final class AddPosition extends NewMemoryEvent {
  final PositionData position;

  AddPosition({required this.position});
}

final class SetDescription extends NewMemoryEvent {
  final String description;

  SetDescription({required this.description});
}

final class SaveMemory extends NewMemoryEvent {}
