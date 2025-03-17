import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:roadsyouwalked_app/model/media/photo_from_gallery_manager.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaInitial()) {
    on<LoadPhotos>(onLoadPhotos);
  }

  Future<void> onLoadPhotos(
    LoadPhotos event,
    Emitter<MediaState> emit
  ) async {
    final manager = PhotoFromGalleryManager();
    await manager.init();
    List<AssetEntity> photos = await manager.loadPhotos();

    emit(
      MediaLoaded(
        photos: photos
      )
    );
  }
}
