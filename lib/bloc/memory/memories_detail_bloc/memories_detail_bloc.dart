import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

part 'memories_detail_event.dart';
part 'memories_detail_state.dart';

class MemoriesDetailBloc
    extends Bloc<MemoriesDetailEvent, MemoriesDetailState> {
  MemoriesDetailBloc() : super(MemoriesDetailInitial()) {
    on<SetMemoriesDetail>(onSetMemoriesDetail);
  }

  void onSetMemoriesDetail(
    SetMemoriesDetail event,
    Emitter<MemoriesDetailState> emit,
  ) {
    final List<Memory> memories = List.from(event.memories)..sort(
      (a, b) => DateTime.parse(
        b.data.core.timestamp,
      ).compareTo(DateTime.parse(a.data.core.timestamp)),
    );
    emit(MemoriesDetailLoaded(memories: memories));
  }
}
