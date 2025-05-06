import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  
  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<LoginRequest>(onLoginRequest);
    on<SetRememberUser>((event, emit) => emit(LoginLoading(rememberUser: event.rememberUser)));
  }

  Future<void> onLoginRequest(LoginRequest event, Emitter<LoginState> emit) async {
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
            await _userRepository.setAutoLoginCredentials(
              event.username,
              event.password
            );
          }
        } else {
          emit(LoginDenied(rememberUser: state.rememberUser));
        }
      });
    } catch (e) {
      emit(LoginDenied(rememberUser: state.rememberUser));
    }
  }
}
