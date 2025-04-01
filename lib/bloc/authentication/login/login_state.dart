part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  final bool rememberUser;

  const LoginState({required this.rememberUser});
}

final class LoginInitial extends LoginState {
  const LoginInitial(
    {
      super.rememberUser = false,
    }
  );
}

final class LoginLoading extends LoginState {
  const LoginLoading({required super.rememberUser});
}

final class LoginGranted extends LoginState {
  const LoginGranted({required super.rememberUser});
}

final class LoginDenied extends LoginState {
  const LoginDenied({required super.rememberUser});
}
