part of 'media_bloc.dart';

@immutable
sealed class MediaState {
  final List<AssetEntity> photos;

  const MediaState({required this.photos});
}

final class MediaInitial extends MediaState {
  const MediaInitial(
    {
      super.photos = const []
    }
  );
}

final class MediaLoaded extends MediaState {
  const MediaLoaded(
    {
      required super.photos
    }
  );
}
