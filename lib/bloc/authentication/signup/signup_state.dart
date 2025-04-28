part of 'signup_bloc.dart';

@immutable
sealed class SignupState {
  final bool validUsername;
  final File? profileImage;

  const SignupState({required this.validUsername, required this.profileImage});
}

final class SignupInitial extends SignupState {
  const SignupInitial(
    {
      super.validUsername = false,
      super.profileImage
    }
  );
}

final class SignupLoading extends SignupState {
  const SignupLoading(
    {
      required super.validUsername,
      required super.profileImage
    }
  );
}

final class SignupTakingProfileImage extends SignupState {
  const SignupTakingProfileImage(
    {
      required super.validUsername,
      required super.profileImage
    }
  );
}

final class SignupSuccess extends SignupState {
  const SignupSuccess(
    {
      required super.validUsername,
      required super.profileImage
    }
  );
}

final class SignupFailure extends SignupState {
  const SignupFailure(
    {
      required super.validUsername,
      required super.profileImage
    }
  );
}
