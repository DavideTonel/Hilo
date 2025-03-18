import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/model/camera/camera_manager.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<InitializeCamera>(onInitializeCamera);
    on<DisposeCamera>(onDisposeCamera);
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

  }
}
