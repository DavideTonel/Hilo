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
    on<CheckAutoLogin>(onCheckAutoLogin);
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

  Future<void> onCheckAutoLogin(
    CheckAutoLogin event,
    Emitter<UserState> emit,
  ) async {
    try {
      final map = await _userRepository.getAutoLoginCredentials();
      if (map != null) {
        final String username = map["username"]!;
        final String password = map["password"]!;
        await _userRepository
          .checkUserExists(username, password)
          .then((res) {
            if (res) {
              add(Login(username: username, password: password));
            } else {
              emit(UserNoAutoLogin());
            }
          });
      } else {
        emit(UserNoAutoLogin());
      }
    } catch (e) {
      dev.log(e.toString());
      emit(UserNoAutoLogin());
    }
  }
}
