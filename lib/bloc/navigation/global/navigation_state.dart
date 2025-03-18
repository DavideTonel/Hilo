part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

final class SplashUI extends NavigationState {}

final class HomeUI extends NavigationState {}
