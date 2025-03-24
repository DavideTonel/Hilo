part of 'media_bloc.dart';

@immutable
sealed class MediaEvent {}

final class CheckPermission extends MediaEvent {}

final class LoadPhotos extends MediaEvent {}

final class SavePhoto extends MediaEvent {
  final String name;
  final XFile data;

  SavePhoto({required this.name, required this.data});
}
