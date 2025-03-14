import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_home_event.dart';
part 'navigation_home_state.dart';

class NavigationHomeBloc extends Bloc<NavigationHomeEvent, NavigationHomeState> {
  NavigationHomeBloc() : super(MemoryFeedUI()) {
    on<NavigateToMemoryFeed>((event, emit) => emit(MemoryFeedUI()));
    on<NavigateToCalendar>((event, emit) => emit(CalendarUI()));
  }
}
