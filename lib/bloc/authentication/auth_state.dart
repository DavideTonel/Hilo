part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final String? username;
  final String? password;
  const AuthState(
    {
      required this.username,
      required this.password
    }
  );
}

final class AuthInitial extends AuthState {
  const AuthInitial(
    {
      super.username,
      super.password
    }
  );
}

final class Authenticated extends AuthState {
  const Authenticated(
    {
      required super.username,
      required super.password
    }
  );
}

final class Unauthenticated extends AuthState {
  const Unauthenticated(
    {
      super.username,
      super.password
    }
  );
}
