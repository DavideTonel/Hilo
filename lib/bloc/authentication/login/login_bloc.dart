import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/db/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  
  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<LoginRequest>(onLoginRequest);
    on<SetRememberUser>((event, emit) => emit(LoginLoading(rememberUser: event.rememberUser)));
  }

  Future<void> onLoginRequest(LoginRequest event, Emitter<LoginState> emit) async {
    //emit(LoginLoading());
    try {
      await _userRepository
      .checkUserExists(
        event.username,
        event.password
      )
      .then((res) async {
        if (res) {
          emit(LoginGranted(rememberUser: state.rememberUser));
          if (state.rememberUser) {
            final SharedPreferencesAsync prefs = SharedPreferencesAsync();
            await prefs.setString("username", event.username);
            await prefs.setString("password", event.password);
          }
        } else {
          emit(LoginDenied(rememberUser: state.rememberUser));
        }
      });
      //.then((res) => res ? emit(LoginSuccess(rememberUser: state.rememberUser)) : emit(LoginFailure(rememberUser: state.rememberUser)));
    } catch (e) {
      emit(LoginDenied(rememberUser: state.rememberUser)); // TODO: add error message
    }
  }
}
