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

final class LoginSuccess extends LoginState {
  const LoginSuccess({required super.rememberUser});
}

final class LoginFailure extends LoginState {
  const LoginFailure({required super.rememberUser});
}
