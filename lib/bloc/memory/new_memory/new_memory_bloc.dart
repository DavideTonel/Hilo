import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/db/dao/media_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/memory_dao.dart';
import 'package:roadsyouwalked_app/data/repository/memory_repository.dart';
import 'package:roadsyouwalked_app/model/assessment/mood_evaluation.dart';
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
          mediaList: state.mediaList,
          moodEvaluationScore: state.moodEvaluationScore
        )
      );
    });
    on<SaveMemory>(onSaveMemory);
    on<AddMoodEvaluation>(onAddMoodEvaluation);
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
        mediaList: state.mediaList,
        moodEvaluationScore: state.moodEvaluationScore
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
        mediaList: [...state.mediaList, newPendingMedia],
        moodEvaluationScore: state.moodEvaluationScore
      )
    );
  }

  Future<void> onSaveMemory(
    SaveMemory event,
    Emitter<NewMemoryState> emit
  ) async {
    try {
      if (state.moodEvaluationScore == null) {
        throw IncompleteMemoryException("Missing mood evaluation");
      }
      if (
        (state.description == null || state.description!.isEmpty) &&
        state.mediaList.isEmpty
      ) {
        throw IncompleteMemoryException("Missing description or one media");
      }
      final timestamp = DateTime.now().toIso8601String();
      await _memoryRepository.saveMemory(
        MemoryData(
          core: MemoryCoreData(
            id: state.memoryId!,
            creatorId: state.creatorId!,
            timestamp: timestamp,
            description: state.description
          )
        ), 
        state.mediaList,
        MoodEvaluationData(
          core: MoodEvaluationCoreData(
            id: state.memoryId!,
            creatorId: state.creatorId!,
            timestamp: timestamp
          ),
          score: state.moodEvaluationScore!
        )
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
          moodEvaluationScore: state.moodEvaluationScore,
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

  void onAddMoodEvaluation(
    AddMoodEvaluation event,
    Emitter<NewMemoryState> emit
  ) {
    emit(
      NewMemoryInProgress(
        memoryId: state.memoryId,
        creatorId: state.creatorId,
        description: state.description,
        mediaList: state.mediaList,
        moodEvaluationScore: event.moodEvaluationScore
      )
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
