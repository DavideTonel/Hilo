import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/memory/i_memory_repository.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'dart:developer' as dev;

part 'memory_event.dart';
part 'memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  final IMemoryRepository _memoryRepository;

  MemoryBloc(this._memoryRepository)
    : super(
        MemoryInitial(
          year: DateTime.now().year,
          month: DateTime.now().month,
          lastNDays: 7,
        ),
      ) {
    on<LoadMemories>(onLoadMemories);
    on<SetTime>(onSetTime);
  }

  Future<void> onLoadMemories(
    LoadMemories event,
    Emitter<MemoryState> emit,
  ) async {
    try {
      List<Memory> memories;
      switch (event.orderType) {
        case MemoryOrderType.timeline:
          memories = await _memoryRepository.getMemoriesByUserId(event.userId);
          break;
        case MemoryOrderType.byMonth:
          memories = await _memoryRepository.getMemoriesByUserIdAndTime(
            event.userId,
            event.year ?? DateTime.now().year,
            event.month ?? DateTime.now().month,
          );
          break;
        case MemoryOrderType.byYear:
          memories = await _memoryRepository.getMemoriesByUserIdAndTime(
            event.userId,
            event.year ?? DateTime.now().year,
            event.month ?? DateTime.now().month,
          );
          break;
        case MemoryOrderType.lastNDays:
          memories = await _memoryRepository.getMemoriesByUserIdFromDate(
            event.userId,
            DateTime.now().subtract(Duration(days: event.lastNDays ?? 7)),
          );
          break;
      }
      emit(
        MemoriesLoaded(
          memories: memories,
          orderType: event.orderType,
          year: event.year ?? state.year,
          month: event.month ?? state.month,
          lastNDays: event.lastNDays ?? state.lastNDays,
        ),
      );
    } catch (e) {
      emit(
        MemoriesLoaded(
          memories: [],
          orderType: event.orderType,
          year: event.year ?? state.year,
          month: event.month ?? state.month,
          lastNDays: event.lastNDays ?? state.lastNDays,
        ),
      );
    }
  }

  Future<void> onSetTime(SetTime event, Emitter<MemoryState> emit) async {
    int currentMonth = state.month;
    int currentYear = state.year;

    int newMonth = event.month ?? currentMonth;
    int newYear = event.year ?? currentYear;

    if (newMonth < 1 || newMonth > 12) {
      newYear += (newMonth - 1) ~/ 12;
      newMonth = (newMonth - 1) % 12 + 1;
    }

    dev.log("Set time     curr: $currentMonth ----> event: $newMonth");

    await onLoadMemories(
      LoadMemories(
        userId: event.userId,
        orderType: state.orderType,
        year: newYear,
        month: newMonth,
      ),
      emit,
    );
  }
}
