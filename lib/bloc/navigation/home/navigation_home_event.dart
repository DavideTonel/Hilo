part of 'navigation_home_bloc.dart';

@immutable
sealed class NavigationHomeEvent {}

final class NavigateToMemoryFeed extends NavigationHomeEvent {}

final class NavigateToCalendar extends NavigationHomeEvent {}
