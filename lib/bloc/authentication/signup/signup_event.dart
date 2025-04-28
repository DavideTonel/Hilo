part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupRequest extends SignupEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  SignupRequest(
    this.firstName,
    this.lastName,
    this.username,
    this.password
  );
}

final class UsernameCheckRequest extends SignupEvent {
  final String username;

  UsernameCheckRequest(this.username);
}

final class TakeProfileImage extends SignupEvent {}

final class AddProfileImage extends SignupEvent {
  final File? profileImage;

  AddProfileImage(this.profileImage);
}
