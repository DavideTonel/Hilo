import 'dart:io';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/model/media/private_storage_media_manager.dart';
import 'package:roadsyouwalked_app/model/media/private_storage_operation_status.dart';

part 'private_storage_event.dart';
part 'private_storage_state.dart';

class PrivateStorageBloc extends Bloc<PrivateStorageEvent, PrivateStorageState> {
  PrivateStorageBloc() : super(PrivateStorageInitial()) {
    on<Initialize>(onInitialize);
    on<SaveImage>(onSaveImage);
    on<LoadImages>(onLoadImages);
  }

  Future<void> onInitialize(
    Initialize event,
    Emitter<PrivateStorageState> emit
  ) async {
    dev.log("event initialize");
    await state.manager.init().then((status) {
      if (status is OperatationSuccess) {
        dev.log("success to init private storage");
        emit(PrivateStorageLoading(manager: state.manager, images: state.images));
      } else {
        dev.log("failed to init private storage");
        emit(PrivateStorageLoading(manager: state.manager, images: state.images));
      }
    });
  }

  Future<void> onSaveImage(
    SaveImage event,
    Emitter<PrivateStorageState> emit
  ) async {
    await state.manager.saveImage(
      event.creatorId,
      event.image
    ).then((value) {
      emit(
        PrivateStorageLoaded(
          manager: state.manager,
          images: state.images
        )
      );
    });
  }

  Future<void> onLoadImages(
    LoadImages event,
    Emitter<PrivateStorageState> emit
  ) async {
    await state.manager.loadImages(
      event.creatorId
    ).then((images) {
      emit(
        PrivateStorageLoaded(
          manager: state.manager,
          images: images
        )
      );
    });
  }
}
