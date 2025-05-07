import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/memory/i_memory_repository.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';

part 'memory_event.dart';
part 'memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  final IMemoryRepository _memoryRepository;

  MemoryBloc(this._memoryRepository)
    : super(
        MemoryInitial(
          year: DateTime.now().year,
          month: DateTime.now().month,
          lastNDays: 7
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
          lastNDays: event.lastNDays ?? state.lastNDays
        ),
      );
    } catch (e) {
      emit(
        MemoriesLoaded(
          memories: [],
          orderType: event.orderType,
          year: event.year ?? state.year,
          month: event.month ?? state.month,
          lastNDays: event.lastNDays ?? state.lastNDays
        ),
      );
    }
  }

  Future<void> onSetTime(SetTime event, Emitter<MemoryState> emit) async {
    int month = event.month ?? state.month;
    int year = event.year ?? state.year;
    
    if (state.month == 1 && event.month == 0) {
      month = 12;
      year = state.year - 1;
    } else if (state.month == 12 && event.month == 13) {
      month = 1;
      year = state.year + 1;
    }
    
    await onLoadMemories(
      LoadMemories(
        userId: event.userId,
        orderType: state.orderType,
        year: year,
        month: month,
      ),
      emit,
    );
  }
}
