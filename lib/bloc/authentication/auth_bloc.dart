import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/db/user/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc(this._userRepository) : super(AuthInitial()) {
    on<CheckAutoLogin>(onCheckAutoLogin);
  }

  Future<void> onCheckAutoLogin(
    CheckAutoLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final map = await _userRepository.getAutoLoginCredentials();
      if (map != null) {
        final String username = map["username"]!;
        final String password = map["password"]!;
        await _userRepository
          .checkUserExists(username, password)
          .then((res) => res 
            ? emit(
              Authenticated(
                username: username,
                password: password,
              )
            ) : emit(
              Unauthenticated()
            )
          );
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      dev.log(e.toString());
      emit(Unauthenticated());
    }
  }
}
