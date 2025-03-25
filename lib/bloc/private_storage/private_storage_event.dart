part of 'private_storage_bloc.dart';

@immutable
sealed class PrivateStorageEvent {}

final class Initialize extends PrivateStorageEvent {}

final class SaveImage extends PrivateStorageEvent {
  final String name;
  final XFile data;

  SaveImage({required this.name, required this.data});
}

final class LoadImages extends PrivateStorageEvent {
  final String directoryPath;

  LoadImages({required this.directoryPath});
}
