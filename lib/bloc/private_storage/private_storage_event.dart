part of 'private_storage_bloc.dart';

@immutable
sealed class PrivateStorageEvent {}

final class Initialize extends PrivateStorageEvent {}

final class SaveImage extends PrivateStorageEvent {
  final String creatorId;
  final XFile image;

  SaveImage({required this.creatorId, required this.image});
}

final class LoadImages extends PrivateStorageEvent {
  final String creatorId;

  LoadImages({required this.creatorId});
}
