part of 'signup_bloc.dart';

@immutable
sealed class SignupState {
  final bool validUsername;
  final File? profileImage;
  final DateTime? birthday;

  const SignupState({
    required this.validUsername,
    required this.profileImage,
    required this.birthday,
  });
}

final class SignupInitial extends SignupState {
  const SignupInitial({
    super.validUsername = false,
    super.profileImage,
    super.birthday,
  });
}

final class SignupLoading extends SignupState {
  const SignupLoading({
    required super.validUsername,
    required super.profileImage,
    required super.birthday
  });
}

final class SignupTakingProfileImage extends SignupState {
  const SignupTakingProfileImage({
    required super.validUsername,
    required super.profileImage,
    required super.birthday
  });
}

final class SignupSuccess extends SignupState {
  const SignupSuccess({
    required super.validUsername,
    required super.profileImage,
    required super.birthday
  });
}

final class SignupFailure extends SignupState {
  const SignupFailure({
    required super.validUsername,
    required super.profileImage,
    required super.birthday
  });
}
