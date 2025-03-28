part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class CheckAutoLogin extends AuthEvent {}

final class RequestLogin extends AuthEvent {}
