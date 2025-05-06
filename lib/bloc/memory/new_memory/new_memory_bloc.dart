import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/db/dao/media_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/memory_dao.dart';
import 'package:roadsyouwalked_app/data/repository/memory_repository.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_data.dart';
import 'package:roadsyouwalked_app/model/location/i_position_service.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_evaluation_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_position_data.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as dev;

part 'new_memory_event.dart';
part 'new_memory_state.dart';

class NewMemoryBloc extends Bloc<NewMemoryEvent, NewMemoryState> {
  final MemoryRepository _memoryRepository = MemoryRepository();
  final MemoryDao _memoryDao = MemoryDao();
  final MediaDao _mediaDao = MediaDao();

  NewMemoryBloc() : super(NewMemoryInitial()) {
    on<InitNewMemory>(onInitialize);
    on<AddMedia>(onAddMedia);
    on<SetDescription>((event, emit) {
      emit(
        NewMemoryInProgress(
          memoryId: state.memoryId,
          creatorId: state.creatorId,
          description: event.description,
          mediaList: state.mediaList,
          evaluationResultData: state.evaluationResultData,
          positionData: state.positionData,
        ),
      );
    });
    on<SaveMemory>(onSaveMemory);
    on<AddMoodEvaluation>(onAddMoodEvaluation);
    on<AddPosition>(onAddPosition);
    on<RemovePosition>(onRemovePosition);
  }

  Future<void> onInitialize(
    InitNewMemory event,
    Emitter<NewMemoryState> emit,
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
        mediaList: state.mediaList,
        evaluationResultData: state.evaluationResultData,
        positionData: state.positionData,
      ),
    );
  }

  Future<void> onAddMedia(AddMedia event, Emitter<NewMemoryState> emit) async {
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
      creatorId: state.creatorId,
    );

    emit(
      NewMemoryInProgress(
        memoryId: state.memoryId,
        creatorId: state.creatorId,
        description: state.description,
        mediaList: [...state.mediaList, newPendingMedia],
        evaluationResultData: state.evaluationResultData,
        positionData: state.positionData,
      ),
    );
  }

  Future<void> onSaveMemory(
    SaveMemory event,
    Emitter<NewMemoryState> emit,
  ) async {
    try {
      if (state.evaluationResultData == null) {
        throw IncompleteMemoryException("Missing mood evaluation");
      }
      if ((state.description == null || state.description!.isEmpty) &&
          state.mediaList.isEmpty) {
        throw IncompleteMemoryException("Missing description or one media");
      }
      final timestamp = DateTime.now().toIso8601String();
      await _memoryRepository.saveMemory(
        MemoryData(
          core: MemoryCoreData(
            id: state.memoryId!,
            creatorId: state.creatorId!,
            timestamp: timestamp,
            description: state.description,
          ),
          evaluation: MemoryEvaluationData(
            evaluationScaleId: state.evaluationResultData!.evaluationScaleId,
            evaluationResult: state.evaluationResultData!.result,
          ),
          position:
              state.positionData != null
                  ? MemoryPositionData(
                    latitude: state.positionData!.latitude,
                    longitude: state.positionData!.longitude,
                  )
                  : null,
        ),
        state.mediaList,
        state.evaluationResultData!.singleItemScores,
      );
      emit(NewMemorySaveSuccess());
    } on IncompleteMemoryException catch (e) {
      dev.log(e.toString());
      emit(
        NewMemorySaveFailure(
          memoryId: state.memoryId,
          creatorId: state.creatorId,
          description: state.description,
          mediaList: state.mediaList,
          evaluationResultData: state.evaluationResultData,
          positionData: state.positionData,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      dev.log(e.toString());
      emit(NewMemorySaveFailure());
    }
  }

  void onAddMoodEvaluation(
    AddMoodEvaluation event,
    Emitter<NewMemoryState> emit,
  ) {
    emit(
      NewMemoryInProgress(
        memoryId: state.memoryId,
        creatorId: state.creatorId,
        description: state.description,
        mediaList: state.mediaList,
        evaluationResultData: event.evaluationResultData,
        positionData: state.positionData,
      ),
    );
  }

  void onAddPosition(AddPosition event, Emitter<NewMemoryState> emit) {
    emit(
      NewMemoryInProgress(
        memoryId: state.memoryId,
        creatorId: state.creatorId,
        description: state.description,
        mediaList: state.mediaList,
        evaluationResultData: state.evaluationResultData,
        positionData: event.position,
      ),
    );
  }

  void onRemovePosition(RemovePosition event, Emitter<NewMemoryState> emit) {
    emit(
      NewMemoryInProgress(
        memoryId: state.memoryId,
        creatorId: state.creatorId,
        description: state.description,
        mediaList: state.mediaList,
        evaluationResultData: state.evaluationResultData,
        positionData: null,
      ),
    );
  }
}

// TODO: move in another file
class IncompleteMemoryException implements Exception {
  final String message;
  IncompleteMemoryException([this.message = "Memory is empty"]);

  @override
  String toString() => "IncompleteMemoryException: $message";
}
