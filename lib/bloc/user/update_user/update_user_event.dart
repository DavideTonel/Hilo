part of 'update_user_bloc.dart';

@immutable
sealed class UpdateUserEvent {}

final class AddProfileImage extends UpdateUserEvent {
  final File? profileImage;

  AddProfileImage({required this.profileImage});
}

final class UpdateUser extends UpdateUserEvent {
  final User user;

  UpdateUser({required this.user});
}

final class TakeProfileImage extends UpdateUserEvent {}
