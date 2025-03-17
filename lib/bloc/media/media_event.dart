part of 'media_bloc.dart';

@immutable
sealed class MediaEvent {}

final class LoadPhotos extends MediaEvent {}
