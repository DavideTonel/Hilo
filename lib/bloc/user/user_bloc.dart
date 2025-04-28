import 'dart:io';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/user_repository.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<Login>(onLogin);
    on<Logout>(onLogout);
    on<UpdateProfileImage>(onUpdateProfileImage);
    on<TakeProfileImage>((event, emit) {
      emit(
        UserTakingProfileImage(
          user: state.user
        )
      );
    });
  }

  Future<void> onLogin(
    Login event,
    Emitter<UserState> emit
  ) async {
    try {
    await _userRepository.getUser(event.username, event.password).then((user) {
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        dev.log("Initial");
        emit(UserInitial());
      }
    });
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> onLogout(
    Logout event,
    Emitter<UserState> emit
  ) async {
    await _userRepository.deleteAutoLoginCredentials();
    emit(UserInitial());
  }

  Future<void> onUpdateProfileImage(
    UpdateProfileImage event,
    Emitter<UserState> emit
  ) async {
    try {
      await _userRepository.updateProfileImage(state.user!.username, event.profileImage);
      await onLogin(
        Login(
          username: state.user!.username,
          password: state.user!.password
        ),
        emit
      );
    } catch (e) {
      // TODO: error message
      dev.log(e.toString());
    }
  }
}
