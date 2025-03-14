part of 'navigation_home_bloc.dart';

@immutable
sealed class NavigationHomeState {}

final class MemoryFeedUI extends NavigationHomeState {}

final class CalendarUI extends NavigationHomeState {}
