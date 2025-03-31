import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/db/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final SharedPreferencesAsync prefs = SharedPreferencesAsync();
      final username = await prefs.getString("username");
      final password = await prefs.getString("password");
      if (username != null && password != null) {
        await _userRepository.checkUserExists(username, password).then((res) => res ? emit(Authenticated()) : emit(Unauthenticated()));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }
}
