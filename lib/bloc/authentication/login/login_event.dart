part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginRequest extends LoginEvent {
  final String username;
  final String password;

  LoginRequest(this.username, this.password);
}

final class SetRememberUser extends LoginEvent {
  final bool rememberUser;

  SetRememberUser(this.rememberUser);
}
