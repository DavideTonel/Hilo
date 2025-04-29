part of 'update_user_bloc.dart';

@immutable
sealed class UpdateUserState {
  final User user;
  final File? newProfileImage;

  const UpdateUserState({required this.user, required this.newProfileImage});
}

final class UpdateUserInitial extends UpdateUserState {
  const UpdateUserInitial({
    required super.user,
    required super.newProfileImage,
  });
}

final class UpdateUserInProgress extends UpdateUserState {
  const UpdateUserInProgress({
    required super.user,
    required super.newProfileImage,
  });
}

final class UserTakingProfileImage extends UpdateUserState {
  const UserTakingProfileImage({
    required super.user,
    required super.newProfileImage,
  });
}
