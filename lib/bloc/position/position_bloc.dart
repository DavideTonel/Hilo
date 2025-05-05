import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/model/location/i_position_service.dart';

part 'position_event.dart';
part 'position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  final IPositionService _positionService = PositionService();

  PositionBloc() : super(PositionInitial()) {
    on<InitPosition>(onInitialize);
    on<GetPosition>(onGetPosition);
    on<ClearPosition>(onClearPosition);
  }

  Future<void> onInitialize(
    InitPosition event,
    Emitter<PositionState> emit,
  ) async {
    await _positionService.ensureReady();
    final permissionGranted = _positionService.permissionGranted;
    final serviceEnabled = _positionService.serviceEnabled;

    if (!_positionService.permissionGranted) {
      emit(
        PositionDenied(
          permissionGranted: permissionGranted,
          serviceEnabled: serviceEnabled
        )
      );
    } else if (!_positionService.serviceEnabled) {
      emit(
        PositionDisabled(
          permissionGranted: permissionGranted,
          serviceEnabled: serviceEnabled,
        )
      );
    } else {
      emit(
        PositionLoaded(
          permissionGranted: permissionGranted,
          serviceEnabled: serviceEnabled,
          position: null,
        ),
      );
    }
  }

  Future<void> onGetPosition(
    GetPosition event,
    Emitter<PositionState> emit,
  ) async {
    if (!state.permissionGranted) {
      emit(
        PositionDenied(
          permissionGranted: state.permissionGranted,
          serviceEnabled: state.serviceEnabled
        )
      );
    } else if (!state.serviceEnabled) {
      emit(
        PositionDisabled(
          permissionGranted: state.permissionGranted,
          serviceEnabled: state.serviceEnabled,
        )
      );
    } else {
      emit(
        PositionLoading(
          permissionGranted: state.permissionGranted,
          serviceEnabled: state.permissionGranted,
        )
      );
      final position = await _positionService.getCurrentPosition();
      emit(
        PositionLoaded(
          permissionGranted: state.permissionGranted,
          serviceEnabled: state.permissionGranted,
          position: position
        )
      );
    }
  }

  void onClearPosition(
    ClearPosition event,
    Emitter<PositionState> emit,
  ) {
    emit(
      PositionLoaded(
        permissionGranted: state.permissionGranted,
        serviceEnabled: state.serviceEnabled,
        position: null,
      ),
    );
  }
}
