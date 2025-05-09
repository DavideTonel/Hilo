import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/model/camera/camera_manager.dart';
import 'package:roadsyouwalked_app/model/camera/camera_access_status.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<InitCamera>(onInitializeCamera);
    on<DisposeCamera>(onDisposeCamera);
    on<TakePhoto>(onTakePhoto);
    on<AcceptMedia>((event, emit) {
      emit(
        CameraMediaAccepted(
          cameraManager: state.cameraManager,
          photoTaken: state.photoTaken
        )
      );
    });
    on<DiscardMedia>((event, emit) {
      emit(
        CameraLoaded(cameraManager: state.cameraManager)
      );
    });
  }

  Future<void> onInitializeCamera(
    InitCamera event,
    Emitter<CameraState> emit
  ) async {
    await state.cameraManager.getAvailableCameras().then((cameras) async {
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.last,
      );
      await state.cameraManager.initializeCamera(frontCamera).then((status) {
        if (status == CameraAccessStatus.granted) {
          emit(CameraLoaded(cameraManager: state.cameraManager));
        } else {
          emit(CameraDenied(cameraManager: state.cameraManager));
        }
      });
    });
  }

  Future<void> onDisposeCamera(
    DisposeCamera event,
    Emitter<CameraState> emit
  ) async {
    state.cameraManager.disposeCamera();
    emit(
      CameraInitial()
    );
  }

  Future<void> onTakePhoto(
    TakePhoto event,
    Emitter<CameraState> emit
  ) async {
    await state.cameraManager.takePhoto().then((file) {
      emit(
        CameraMediaTaken(
          cameraManager: state.cameraManager,
          photoTaken: file!
        )
      );
    });
  }
}
