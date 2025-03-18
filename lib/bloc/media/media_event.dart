part of 'media_bloc.dart';

@immutable
sealed class MediaEvent {}

final class CheckPermission extends MediaEvent {}

final class LoadPhotos extends MediaEvent {}
