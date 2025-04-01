part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class Login extends UserEvent {
  final String username;
  final String password;

  Login({required this.username, required this.password});
}

final class Logout extends UserEvent {}
