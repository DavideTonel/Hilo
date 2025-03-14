part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

final class NavigateToHome extends NavigationEvent {}
