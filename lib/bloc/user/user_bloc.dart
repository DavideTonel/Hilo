import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/db/user/user_repository.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';

import 'dart:developer' as dev;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<Login>(onLogin);
    on<Logout>((event, emit) => emit(UserInitial()));
  }

  Future<void> onLogin(Login event, Emitter<UserState> emit) async {
    dev.log("logging user");
    await _userRepository.getUser(event.username, event.password).then((user) {
      if (user != null) {
        dev.log("user logged in");
        emit(UserLoaded(user: user));
      } else {
        dev.log("user not found");
        emit(UserInitial());
      }
    });
  }
}
