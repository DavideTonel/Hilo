part of 'media_bloc.dart';

@immutable
sealed class MediaState {
  final List<AssetEntity> photos;
  final PhotoFromGalleryManager manager;

  const MediaState({required this.photos, required this.manager});
}

final class MediaInitial extends MediaState {
  MediaInitial(
    {
      super.photos = const [],
    }
  ) : super(manager: PhotoFromGalleryManager());
}

final class MediaLoaded extends MediaState {
  const MediaLoaded(
    {
      required super.photos,
      required super.manager
    }
  );
}

final class MediaPermissionChecking extends MediaState {
  const MediaPermissionChecking({super.photos = const [], required super.manager});
}

final class MediaPermissionDenied extends MediaState {
  const MediaPermissionDenied({super.photos = const [], required super.manager});
}

final class MediaPermissionGranted extends MediaState {
  const MediaPermissionGranted({super.photos = const [], required super.manager});
}
