part of 'new_memory_bloc.dart';

@immutable
sealed class NewMemoryEvent {}

final class Initialize extends NewMemoryEvent {
  final String creatorId;

  Initialize({required this.creatorId});
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

final class SaveMemory extends NewMemoryEvent {}
