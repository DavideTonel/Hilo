import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/model/camera/camera_manager.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<InitializeCamera>(onInitializeCamera);
    on<DisposeCamera>(onDisposeCamera);
    on<TakePhoto>(onTakePhoto);
  }

  Future<void> onInitializeCamera(
    InitializeCamera event,
    Emitter<CameraState> emit
  ) async {
    await state.cameraManager.getAvailableCameras().then((cameras) async {
      await state.cameraManager.initializeCamera(cameras.last).then((_) {
        emit(CameraLoaded(cameraManager: state.cameraManager));
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
        CameraPhotoTaken(
          cameraManager: state.cameraManager,
          photoTaken: file!
        )
      );
    });
  }
}
