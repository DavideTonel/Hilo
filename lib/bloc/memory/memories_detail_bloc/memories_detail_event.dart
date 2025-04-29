part of 'memories_detail_bloc.dart';

@immutable
sealed class MemoriesDetailEvent {}

final class SetMemoriesDetail extends MemoriesDetailEvent {
  final List<Memory> memories;

  SetMemoriesDetail({required this.memories});
}
