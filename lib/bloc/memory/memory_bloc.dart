import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/memory_repository.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';

import 'dart:developer' as dev;

import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:uuid/uuid.dart';

part 'memory_event.dart';
part 'memory_state.dart';

// TODO:
// 1. create UI to create a memory
// 2. create new bloc to handle memory creation
class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  final MemoryRepository _memoryRepository;

  MemoryBloc(this._memoryRepository) : super(MemoryInitial()) {
    on<LoadMemoriesByUserId>(onLoadMemoriesByUserId);
    on<SaveMemory>(onSaveMemory);
  }

  Future<void> onLoadMemoriesByUserId(
    LoadMemoriesByUserId event,
    Emitter<MemoryState> emit
  ) async {
    dev.log("loading memories");
    await _memoryRepository.getMemoriesByUserId(event.userId).then((memories) {
      dev.log("memories in bloc: ${memories.length}");
      emit(MemoriesLoaded(memories: memories));
    });
  }

  Future<void> onSaveMemory(
    SaveMemory event,
    Emitter<MemoryState> emit
  ) async {
    try {
      final uuid = const Uuid();
      final memoryId = uuid.v4();
      final creatorId = event.creatorId;
      final timestamp = DateTime.now().toIso8601String();

      final mediaId = uuid.v4();
      await _memoryRepository.saveMemory(
        MemoryData(
          core: MemoryCoreData(id: memoryId, creatorId: creatorId, timestamp: timestamp)
        ),
        [PendingMedia(id: mediaId, type: event.type, localFile: event.file, remoteUri: null, memoryId: memoryId, creatorId: creatorId)]
      );
      await _memoryRepository.getMemoriesByUserId(creatorId).then((memories) => emit(
        MemoriesLoaded(memories: memories)
      ));
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
