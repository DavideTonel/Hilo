import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:roadsyouwalked_app/model/media/photo_from_gallery_manager.dart';
import 'dart:developer' as dev;

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(MediaInitial()) {
    on<CheckPermission>(onCheckPermission);
    on<LoadPhotos>(onLoadPhotos);
  }

  Future<void> onLoadPhotos(
    LoadPhotos event,
    Emitter<MediaState> emit
  ) async {
    List<AssetEntity> photos = await state.manager.loadPhotos();

    emit(
      MediaLoaded(
        photos: photos,
        manager: state.manager
      )
    );
  }

  Future<void> onCheckPermission(
    CheckPermission event,
    Emitter<MediaState> emit
  ) async {
    await state.manager.init();
    if (state.manager.hasPermission) {
      dev.log("Permission granted");
      emit(
        MediaPermissionGranted(
          manager: state.manager
        )
      );
    } else {
      dev.log("Permission denied");
      emit(
        MediaPermissionDenied(
          manager: state.manager
        )
      );
    }
  }
}
