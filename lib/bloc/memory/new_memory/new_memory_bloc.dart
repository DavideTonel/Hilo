import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/db/dao/media_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/memory_dao.dart';
import 'package:roadsyouwalked_app/data/repository/memory_repository.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as dev;

part 'new_memory_event.dart';
part 'new_memory_state.dart';

class NewMemoryBloc extends Bloc<NewMemoryEvent, NewMemoryState> {
  final MemoryRepository _memoryRepository = MemoryRepository();
  final MemoryDao _memoryDao = MemoryDao();
  final MediaDao _mediaDao = MediaDao();

  NewMemoryBloc() : super(NewMemoryInitial()) {
    on<Initialize>(onInitialize);
    on<AddMedia>(onAddMedia);
    on<SetDescription>((event, emit) {
      emit(
        NewMemoryInProgress(
          memoryId: state.memoryId,
          creatorId: state.creatorId,
          description: event.description,
          mediaList: state.mediaList
        )
      );
    });
    on<SaveMemory>(onSaveMemory);
  }

  Future<void> onInitialize(
    Initialize event,
    Emitter<NewMemoryState> emit
  ) async {
    final uuid = const Uuid();
    final String creatorId = event.creatorId;
    String memoryId = uuid.v4();

    while (!await _memoryDao.isValidId(memoryId, creatorId)) {
      memoryId = uuid.v4();
    }

    emit(
      NewMemoryInProgress(
        memoryId: memoryId, 
        creatorId: creatorId, 
        description: state.description, 
        mediaList: state.mediaList
      )
    );
  }

  Future<void> onAddMedia(
    AddMedia event,
    Emitter<NewMemoryState> emit
  ) async {
    final uuid = const Uuid();
    String mediaId = uuid.v4();

    while (!await _mediaDao.isValidId(mediaId)) {
      mediaId = uuid.v4();
    }

    final PendingMedia newPendingMedia = PendingMedia(
      id: mediaId,
      localFile: event.localFile,
      remoteUri: event.remoteUri,
      type: event.mediaType,
      memoryId: state.memoryId,
      creatorId: state.creatorId
    );

    emit(
      NewMemoryInProgress(
        memoryId: state.memoryId,
        creatorId: state.creatorId,
        description: state.description,
        mediaList: [...state.mediaList, newPendingMedia]
      )
    );
  }

  Future<void> onSaveMemory(
    SaveMemory event,
    Emitter<NewMemoryState> emit
  ) async {
    try {
      if (
        (state.description == null || state.description!.isEmpty) &&
        state.mediaList.isEmpty
      ) {
        throw IncompleteMemoryException("Missing description or one media");
      }
      await _memoryRepository.saveMemory(
        MemoryData(
          core: MemoryCoreData(
            id: state.memoryId!,
            creatorId: state.creatorId!,
            timestamp: DateTime.now().toIso8601String(),
            description: state.description
          )
        ), 
        state.mediaList
      );
      emit(
        NewMemorySaveSuccess()
      );
    } on IncompleteMemoryException catch (e) {
      dev.log(e.toString());
      emit(
        NewMemorySaveFailure(
          memoryId: state.memoryId,
          creatorId: state.creatorId,
          description: state.description,
          mediaList: state.mediaList,
          errorMessage: e.message
        )
      );
    } catch (e) {
      dev.log(e.toString());
      emit(
        NewMemorySaveFailure()
      );
    }
  }
}

class IncompleteMemoryException implements Exception {
  final String message;
  IncompleteMemoryException([this.message = "Memory is empty"]);

  @override
  String toString() => "IncompleteMemoryException: $message";
}
