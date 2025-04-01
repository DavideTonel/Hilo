part of 'user_bloc.dart';

@immutable
sealed class UserState {
  final User? user;

  const UserState({required this.user});
}

final class UserInitial extends UserState {
  const UserInitial(
    {
      super.user
    }
  );
}

final class UserLoaded extends UserState {
  const UserLoaded(
    {
      required super.user
    }
  );
}

