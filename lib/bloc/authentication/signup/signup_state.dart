part of 'signup_bloc.dart';

@immutable
sealed class SignupState {
  final bool validUsername;

  const SignupState({required this.validUsername});
}

final class SignupInitial extends SignupState {
  const SignupInitial(
    {
      super.validUsername = false,
    }
  );
}

final class SignupLoading extends SignupState {
  const SignupLoading(
    {
      required super.validUsername
    }
  );
}

final class SignupSuccess extends SignupState {
  const SignupSuccess(
    {
      required super.validUsername
    }
  );
}

final class SignupFailure extends SignupState {
  const SignupFailure(
    {
      required super.validUsername
    }
  );
}
